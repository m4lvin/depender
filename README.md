# depender

See <https://github.com/commercialhaskell/stack/issues/4141>.

This is a minimal example of a Haskell program which depends on a [minimal example library that includes a C/C++ library](https://github.com/jakubfijalkowski/haskell-and-cpp).

It can be built with the current stable version of stack, but not with the current master:

~~~
~/depender $ rm -rf .stack-work/
~/depender $ stack --version
Version 1.9.3, Git revision 40cf7b37526b86d1676da82167ea8758a854953b (6211 commits) x86_64 hpack-0.31.1
~/depender $ stack build
Cloning 3dec37dabdb93fda25663435dc58b8781f8b0b77 from https://github.com/jakubfijalkowski/haskell-and-cpp.git
Cloning into '/home/malvin/depender/.stack-work/downloaded/m4pOjgAl5aii'...
remote: Enumerating objects: 47, done.
remote: Total 47 (delta 0), reused 0 (delta 0), pack-reused 47
Unpacking objects: 100% (47/47), done.

Warning: Wildcard does not match any files: ext_lib/*.c
         in directory: /home/malvin/depender/.stack-work/downloaded/m4pOjgAl5aii/
haskell-and-cpp-0.1: configure (lib)
haskell-and-cpp-0.1: build (lib)

Warning: Wildcard does not match any files: ext_lib/*.c
         in directory: /home/malvin/depender/.stack-work/downloaded/m4pOjgAl5aii/
haskell-and-cpp-0.1: copy/register
depender-0.1.0.0: configure (lib)
Configuring depender-0.1.0.0...
depender-0.1.0.0: build (lib)
Preprocessing library for depender-0.1.0.0..
Building library for depender-0.1.0.0..
[1 of 2] Compiling Lib              ( src/Lib.hs, .stack-work/dist/x86_64-linux/Cabal-2.4.0.1/build/Lib.o )
[2 of 2] Compiling Paths_depender   ( .stack-work/dist/x86_64-linux/Cabal-2.4.0.1/build/autogen/Paths_depender.hs, .stack-work/dist/x86_64-linux/Cabal-2.4.0.1/build/Paths_depender.o )
depender-0.1.0.0: copy/register
Installing library in /home/malvin/depender/.stack-work/install/x86_64-linux/lts-13.22/8.6.5/lib/x86_64-linux-ghc-8.6.5/depender-0.1.0.0-CrloMsOX6dcA6ReLezLU2p
Registering library for depender-0.1.0.0..
Completed 2 action(s).
~/depender $ stack ghci

Warning: Wildcard does not match any files: ext_lib/*.c
         in directory: /home/malvin/depender/.stack-work/downloaded/m4pOjgAl5aii/

Warning: Wildcard does not match any files: ext_lib/*.c
         in directory: /home/malvin/depender/.stack-work/downloaded/m4pOjgAl5aii/
Configuring GHCi with the following packages: depender
GHCi, version 8.6.5: http://www.haskell.org/ghc/  :? for help
Loaded GHCi configuration from /home/malvin/.ghci
[1 of 1] Compiling Lib              ( /home/malvin/depender/src/Lib.hs, interpreted )
Ok, one module loaded.
Loaded GHCi configuration from /tmp/haskell-stack-ghci/c6e38927/ghci-script
λ> someFunc
C++ method called!
785
λ> :q
Leaving GHCi.
~~~

But with the current stack master:

~~~
~/depender $ rm -rf .stack-work
~/depender $ newstack --version
Version 2.2.0, Git revision f6258124cff9a7e92bcb5704164a70e149080e88 (7597 commits) x86_64 hpack-0.31.1
~/depender $ newstack build
depender> configure (lib)
Configuring depender-0.1.0.0...
depender> build (lib)
Preprocessing library for depender-0.1.0.0..
Building library for depender-0.1.0.0..
[1 of 2] Compiling Lib
[2 of 2] Compiling Paths_depender
/usr/bin/ld.gold: error: cannot find -lext
collect2: error: ld returned 1 exit status
`gcc' failed in phase `Linker'. (Exit code: 1)

--  While building package depender-0.1.0.0 using:
      /home/malvin/.stack/setup-exe-cache/x86_64-linux/Cabal-simple_mPHDZzAJ_2.4.0.1_ghc-8.6.5 --builddir=.stack-work/dist/x86_64-linux/Cabal-2.4.0.1 build lib:depender --ghc-options " -fdiagnostics-color=always"
    Process exited with code: ExitFailure 1
~/depender $
~~~
