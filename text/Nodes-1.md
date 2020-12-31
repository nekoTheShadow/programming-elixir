/devでノードBを起動する。

```
$ pwd
/dev
$
$ iex --sname b
Erlang/OTP 23 [erts-11.1.4] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1]

Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(b@DESKTOP-MP2H07E)1>
```

/varでノードAを起動し、ノードAとノードBで関数fを実行する。

```
$ pwd
/var
$
$ iex --sname a
Erlang/OTP 23 [erts-11.1.4] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1]

Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(a@DESKTOP-MP2H07E)1> f = fn -> (File.ls!(".") |> Enum.join(",") |> IO.puts()) end
#Function<45.79398840/0 in :erl_eval.expr/5>
iex(a@DESKTOP-MP2H07E)2> Node.connect :"b@DESKTOP-MP2H07E"
true
iex(a@DESKTOP-MP2H07E)3> Node.spawn(:"a@DESKTOP-MP2H07E", f)
spool,lock,crash,backups,opt,lib,cache,run,snap,tmp,local,log,mail
#PID<0.121.0>
iex(a@DESKTOP-MP2H07E)4> Node.spawn(:"b@DESKTOP-MP2H07E", f)
#PID<11796.121.0>
sdd,sg3,sdc,sg2,pts,stderr,stdout,stdin,fd,shm,block,sdb,sg1,sda,bsg,sg0,btrfs-control,memory_bandwidth,network_throughput,network_latency,cpu_dma_latency,vsock,vhost-net,mapper,rtc0,vfio,ppp,net,loop7,loop6,loop5,loop4,loop3,loop2,loop1,loop0,loop-control,ram15,ram14,ram13,ram12,ram11,ram10,ram9,ram8,ram7,ram6,ram5,ram4,ram3,ram2,ram1,ram0,nvram,ttyS3,ttyS2,ttyS1,ttyS0,ptmx,cuse,fuse,autofs,tty63,tty62,tty61,tty60,tty59,tty58,tty57,tty56,tty55,tty54,tty53,tty52,tty51,tty50,tty49,tty48,tty47,tty46,tty45,tty44,tty43,tty42,tty41,tty40,tty39,tty38,tty37,tty36,tty35,tty34,tty33,tty32,tty31,tty30,tty29,tty28,tty27,tty26,tty25,tty24,tty23,tty22,tty21,tty20,tty19,tty18,tty17,tty16,tty15,tty14,tty13,tty12,tty11,tty10,tty9,tty8,tty7,tty6,tty5,tty4,tty3,tty2,tty1,vcsa1,vcsu1,vcs1,vcsa,vcsu,vcs,tty0,console,tty,kmsg,urandom,random,full,zero,null,mem
```