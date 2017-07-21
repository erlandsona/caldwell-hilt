# caldwell-hilt
Playin' around with Hilt as alternative to servant?




Trying to go through...
https://github.com/supermario/hilt#setup

I may just be having stack issues, but I'm having trouble knowing where / what to look into to resolve.
Had to look at the stack.yml in oak repo to get past initial issues.
Scratch that had to grab the latest commit sha...
```
❯ stack build

Error: While constructing the build plan, the following exceptions were encountered:

In the dependencies for caldwell-hilt-0.1.0.0:
    hilt must match -any, but the stack configuration has no specified version

Plan construction failed.
 erlandsona  ~/code/personal/caldwell-hilt  1 
❯ stack build
Could not parse '/Users/erlandsona/code/personal/caldwell-hilt/stack.yaml':
YAML parse exception at line 27, column 0,
while parsing a block mapping:
did not find expected key
See http://docs.haskellstack.org/en/stable/yaml_configuration/
 erlandsona  ~/code/personal/caldwell-hilt  1 
❯ stack build
No compiler found, expected minor version match with ghc-8.0.1 (x86_64) (based on resolver setting in /Users/erlandsona/code/personal/caldwell-hilt/stack.yaml).
To install the correct GHC into /Users/erlandsona/.stack/programs/x86_64-osx/, try running "stack setup" or use the "--install-ghc" flag.
 erlandsona  ~/code/personal/caldwell-hilt  1 
❯ stack setup
Preparing to install GHC to an isolated location.
This will not interfere with any system-level installation.
ghc-8.0.1:   65.81 MiB / 190.14 MiB ( 34.61%) downloaded...^Cuser interrupt
 erlandsona  ~/code/personal/caldwell-hilt  1 
❯ stack setup
Preparing to install GHC to an isolated location.
This will not interfere with any system-level installation.
Downloaded ghc-8.0.1.
Installed GHC.
stack will use a sandboxed GHC it installed
For more information on paths, see 'stack path' and 'stack exec env'
To use this GHC and packages outside of a project, consider using:
stack ghc, stack ghci, stack runghc, or stack exec
 erlandsona  ~/code/personal/caldwell-hilt 
❯ stack build
Cloning into '/Users/erlandsona/code/personal/caldwell-hilt/.stack-work/downloaded/cmPqFU63o47v'...
remote: Counting objects: 371, done.
remote: Compressing objects: 100% (54/54), done.
remote: Total 371 (delta 40), reused 69 (delta 29), pack-reused 286
Receiving objects: 100% (371/371), 71.06 KiB | 0 bytes/s, done.
Resolving deltas: 100% (176/176), done.
No extra-dep setting found for package at URL:

https://github.com/supermario/hilt.git

This is usually a mistake, external packages should typically
be treated as extra-deps to avoid spurious test case failures.

Error: While constructing the build plan, the following exceptions were encountered:

In the dependencies for hilt-0.0.0.1:
    heroku must match -any, but the stack configuration has no specified version (latest applicable is 0.1.2.3)
    heroku-persistent must match -any, but the stack configuration has no specified version (latest applicable is 0.2.0)
    http-dispatch must match -any, but the stack configuration has no specified version (latest applicable is 0.6.2.0)
    unagi-chan must match -any, but the stack configuration has no specified version (latest applicable is 0.4.0.0)
needed due to caldwell-hilt-0.1.0.0 -> hilt-0.0.0.1

Recommended action: try adding the following to your extra-deps in /Users/erlandsona/code/personal/caldwell-hilt/stack.yaml:
- heroku-0.1.2.3
- heroku-persistent-0.2.0
- http-dispatch-0.6.2.0
- unagi-chan-0.4.0.0

You may also want to try the 'stack solver' command
Plan construction failed.
 erlandsona  ~/code/personal/caldwell-hilt  1 
❯ stack solver
Using configuration file: stack.yaml
No extra-dep setting found for package at URL:

https://github.com/supermario/hilt.git

This is usually a mistake, external packages should typically
be treated as extra-deps to avoid spurious test case failures.
Using cabal packages:
- caldwell-hilt.cabal
- .stack-work/downloaded/cmPqFU63o47v/hilt.cabal

Using resolver: lts-7.24
Solver requires that cabal be on your PATH
Try running 'stack install cabal-install'

 erlandsona  ~/code/personal/caldwell-hilt  1 
❯ stack install cabal-install
No extra-dep setting found for package at URL:

https://github.com/supermario/hilt.git

This is usually a mistake, external packages should typically
be treated as extra-deps to avoid spurious test case failures.
```


Okay so I finally got it all to build.
But here's the big question I find myself getting to more often than not nowadays, which is...
Now what?

- I have a semblance of a program with an architectural skeleton I'm on board with, BUT...
    - It's missing all the features I'm used to with Rails. EG:
        - rails db:create db:setup
        - rails generate model name:string
        - AutoLoading

    - I could use Yesod / Rails / [Insert other Monolith Framework here], but that puts me into a similar issue of managing the upkeep of Docs, Api, & Client Code...
    - With Servant I can keep my client calls to the api in sync with the Data Models in the DB and have a means of keeping Documentation in sync with the latest version of the code.
        - Alternately though I don't get quite the cli treatment with Servant like I do Rails.
        - And I have to implement features like Autoloading myself.
- But let's say for a second that I don't care about all the Rails features and I just want to build some CRUD for a User / SomeModel
    - I'm forced back into trade-off's regarding the different features I get from different frameworks...





NOTE:

On Type Classes vs Value Level programming...
monad'ReaderT :: MonadI m -> MonadI (ReaderT s m )
monad'ReaderT i =
    let return = _return i
        (>>=) = _bind i
        lift = _lift monadTrans'ReaderT i
     in MonadI {
            _return = lift . (_return i),
            _bind = \m k -> ReaderT $ \r ->
                runReaderT m r >>= \a ->
                runReaderT (k a) r }

Not sure we're getting much over type classes here?
Otherwise I'm totally down with the added simplicity we get
from the compiler around the misuse of value level programming vs
type class errors.
But I'm not an expert I just watched Edward Kmett's youtube here...
https://www.youtube.com/watch?v=hIZxTQP1ifo
