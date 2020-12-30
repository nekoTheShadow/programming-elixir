defmodule ServerProcess do
  def listen(scheduler_pid) do
    send scheduler_pid, {:ready, self()}
    receive do
      {:request, file_path} ->
        send scheduler_pid, {:response, file_path, count_cat(file_path)}
        listen(scheduler_pid)
      {:shutdown} ->
        exit(:normal)
    end
  end

  def count_cat(file_path) do
    content = File.read!(file_path)
    Regex.scan(~r{cat}, content) |> length
  end
end

defmodule Scheduler do
  def run(living_process_count, file_paths, parent_pid) do
    results = process(living_process_count, file_paths, [])
    send parent_pid, results
  end

  def process(living_process_count, file_paths, results) do
    receive do
      {:ready, server_pid} ->
        if file_paths === [] do
          send server_pid, {:shutdown}
          if living_process_count === 1 do
            results
          else
            process(living_process_count-1, file_paths, results)
          end
        else
          [file_path | tail] = file_paths
          send server_pid, {:request, file_path}
          process(living_process_count, tail, results)
        end

      {:response, file_path, count} ->
        process(living_process_count, file_paths, [{file_path, count} | results])
    end
  end
end

defmodule Main do
  def main(dir_path, living_process_count) do
    file_paths = File.ls!(dir_path) |> Enum.map(&Path.join([dir_path, &1]))

    scheduler_pid = spawn_link(Scheduler, :run, [living_process_count, file_paths, self()])
    Enum.each 1..living_process_count, fn _ ->
      spawn_link(ServerProcess, :listen, [scheduler_pid])
    end

    receive do
      results ->
        for {file_path, count} <- results do
          IO.puts("#{file_path} #{count}")
        end
    end
  end
end
