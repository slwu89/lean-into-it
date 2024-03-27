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
