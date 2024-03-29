-- notes for section 1.6

-- our MyList type, we can write the cons
-- constructor one of two ways, I write it more
-- pedantically and comment out the more elegant one
inductive MyList (α : Type) where
  | nil : MyList α
  -- either of these two ways to write is acceptable
  -- | cons : α → MyList α → MyList α
  | cons (a : α) (l : MyList α) : MyList α
deriving Repr

def explicitPrimesUnder10 : MyList Nat :=
  MyList.cons 2 (MyList.cons 3 (MyList.cons 5 (MyList.cons 7 MyList.nil)))

#check explicitPrimesUnder10
#eval explicitPrimesUnder10

#eval (MyList.cons 1 MyList.nil)
#eval MyList.cons 1 (MyList.cons 1 MyList.nil)
#check MyList.cons 1 MyList.nil

#check MyList Nat

-- how to just make an empty list
def alist : MyList Nat := MyList.nil
#check alist
#eval alist

-- how to make length 1 list
def blist : MyList Nat := MyList.cons 1 MyList.nil
#eval blist

-- args in {} are implicit and you can leave them out and lean will
-- infer them. They are used when the value of that arg is a Type
-- and it can be inferred from later arguments.
def length {α : Type} (xs : MyList α) : Nat :=
  match xs with
  | MyList.nil => Nat.zero
  | MyList.cons y ys => Nat.succ (length ys)

#eval length blist

-- products (pair types)
def fives : String × Int := ( "five", 5 )
#eval fives.snd

-- sum types
def PetName : Type := String ⊕ String

def animals : List PetName :=
  [Sum.inl "Spot", Sum.inr "Tiger", Sum.inl "Fifi", Sum.inl "Rex", Sum.inr "Floof"]

def howManyDogs (pets : List PetName) : Nat :=
  match pets with
  | [] => 0
  | Sum.inl _ :: morePets => (howManyDogs morePets) + 1
  | Sum.inr _ :: morePets => howManyDogs morePets

#eval howManyDogs animals

-- unit type
#eval Unit.unit

-- how the hell to actually get values of Product and Sum types?
-- there ya go
def MyProd : Prod Nat String := (5,"five")
#eval MyProd

def MySum : Sum Nat String := Sum.inl 5
#eval MySum

-- exercises:
-- 1.
def MyList.last? {α : Type} (xs : MyList α) : Option α :=
  match xs with
  | MyList.cons y MyList.nil => some y
  | MyList.cons _ ys => MyList.last? ys
  | MyList.nil => none

#eval MyList.last? explicitPrimesUnder10
#eval MyList.last? alist
#eval MyList.last? blist

-- 2.
def MyList.findFirst? {α : Type} (xs : MyList α) (predicate : α → Bool) : Option α :=
  match xs with
  | MyList.nil => none
  | MyList.cons y ys => if predicate y then some y else MyList.findFirst? ys predicate


def biggerThanFive (n : Nat) : Bool := n > 5

#eval MyList.findFirst? explicitPrimesUnder10 biggerThanFive

-- 3.
-- apparently you can write a product type just with ()
-- and the type will be inferred.
def Prod.swap {α β : Type} (pair : α × β) : β × α :=
  (pair.snd, pair.fst)

#eval Prod.swap ( "five", 5 )

-- 4.
inductive CharacterNames (α : Type) : Type where
  | kenshin : α → CharacterNames α
  | fma : α → CharacterNames α
deriving Repr

def characters : List (CharacterNames String) :=
  [CharacterNames.kenshin "Yahiko", CharacterNames.fma "Edward"]

-- 5.
def zip {α β : Type} (xs : List α) (ys : List β) : List (α × β) :=
  match xs, ys with
  | List.nil, List.nil => List.nil
  | List.cons x xs, List.cons y ys => List.cons (x, y) (zip xs ys)
  | List.cons x xs, List.nil => List.nil
  | List.nil, List.cons y ys => List.nil

-- same length
#eval zip ([1,2,3] : List Nat) (["k","thx","bai"] : List String)

-- x longer
#eval zip ([1,2,3] : List Nat) (["k","thx"] : List String)

-- y longer
#eval zip ([1,2] : List Nat) (["k","thx","bai"] : List String)

-- both zeros
#eval zip ([] : List Nat) ([] : List String)

-- 6.
def take {α : Type} (n : Nat) (xs : List α) : List α :=
  match n, xs with
  | Nat.zero, List.cons y ys => List.nil
  | Nat.zero, List.nil => List.nil
  | Nat.succ k, List.nil => List.nil
  | Nat.succ k, List.cons y ys => List.cons y (take k ys)

#eval take 3 ["bolete", "oyster"]
#eval take 2 ["bolete", "oyster"]
#eval take 1 ["bolete", "oyster"]
#eval take 0 ["bolete", "oyster"]

#eval take 1 ([] : List String)
#eval take 0 ([] : List String)

-- 7.
-- def dist_prod {α β γ : Type} (x : (α × (β ⊕ γ))) : (α × β) ⊕ (α × γ) :=
--   (x.fst × (x.snd).inl) ⊕ (x.fst × (x.snd).inr)

-- def dist_prod {α β γ : Type} (x : (α × (β ⊕ γ))) : α × β :=
--   x.fst × (x.snd).

-- def x := (5, Sum String Nat )
-- #check x
