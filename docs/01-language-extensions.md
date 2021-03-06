Extensions from https://github.com/commercialhaskell/rio#language-extensions

# common

RankNTypes - allow to use forall within forall, e.g. `forall a. a -> (forall b. b -> a)`

TupleSections - allow use (,,, )

# for https://hackage.haskell.org/package/first-class-families (e.g. allows to compose functors without newtype)

- DataKinds - user defined kinds through datatype promotion, allows

```hs
hetero :: '[] :~~: '[]
hetero = HRefl
```

- PolyKinds - enables kind polymorphism

```
Haskell has:
- lifted types (kind *)
- unlifted type (kind * -> ...)
- unboxed types (kind #, just like * except that the types with kind # aren't behind a pointer)
```

TODO: continue

- TypeFamilies - allows use family declarations (`data family`) and associated data types in class (`class Foo where data Bar :: *`)

- TypeInType (maybe unsafe!!!) - Type becomes a synonym of `*`, so instead of rather cryptic `*->*` we can write a self explanatory `Type -> Type`. Also, the kind of `Type` is also `Type`

- TypeOperators - allows to make `type (○) f g a = f (g a)`

- UndecidableInstances (maybe unsafe!!!) - by default right instance - if all of the parameters of the typeclass get smaller as you walk backwards into the instance dependencies, but with `UndecidableInstances` ........................

TODO: (read)[https://www.reddit.com/r/haskell/comments/5zjwym/when_is_undecidableinstances_okay_to_use/deynhlx/]

# Other

- MultiParamTypeClasses - allows type classes which can take multiple arguments - Multi-parameter type class (MPTC)

```hs
class Monad m => VarMonad m v where
  new :: a -> m (v a)
  get :: v a -> m a
  put :: v a -> a -> m ()

instance VarMonad IO IORef where ...
instance VarMonad (ST s) (STRef s) where ...
```

- FunctionalDependencies - Naive use of MPTCs may result in ambiguity, so functional dependencies were developed as a method of resolving that ambiguity, declaring that some subset of the parameters is sufficient to determine the values of the others

- ExistentialQuantification - TODO: https://downloads.haskell.org/~ghc/7.8.3/docs/html/users_guide/data-type-extensions.html#existential-quantification

FlexibleContexts - allows to have any type inside a typeclass

```hs
-- by default you can only

add :: Num a => a -> a
add = (+)

-- but with FlexibleContexts

intAdd :: Num Int => Int -> Int
intAdd = (+)
```

BangPatterns
BinaryLiterals
ConstraintKinds
DefaultSignatures
DoAndIfThenElse
EmptyDataDecls
FlexibleInstances
GADTs
InstanceSigs
KindSignatures
LambdaCase
MonadFailDesugaring
MultiWayIf
NamedFieldPuns
NoImplicitPrelude
OverloadedStrings
PartialTypeSignatures
PatternGuards
RecordWildCards
ScopedTypeVariables
TypeSynonymInstances
ViewPatterns

TypeApplication (maybe unsafe!!!) - allows to specify type `read @Int "3"`

# Derive
DeriveDataTypeable
DeriveFoldable
DeriveFunctor
DeriveGeneric
DeriveTraversable
GeneralizedNewtypeDeriving
AutoDeriveTypeable
StandaloneDeriving
