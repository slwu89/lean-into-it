-- type classes (like interfaces in C++)
-- let's make one for positive numbers
inductive Pos : Type where
  | one : Pos
  | succ : Pos → Pos
deriving Repr

-- type class Plus exists that overloads op for α
class Plus (α : Type) where
  plus : α → α → α

-- this overloads for Nat, so Nat is now in the Plus type class
instance : Plus Nat where
  plus := Nat.add

open Plus (plus)
#eval plus 5 3

-- let's get Pos into this type class
def Pos.plus (n : Pos) (k : Pos) : Pos :=
  match n, k with
  | Pos.one, k => Pos.succ k
  | Pos.succ n, k => Pos.succ (n.plus k)

instance : Plus Pos where
  plus := Pos.plus

def seven : Pos :=
  Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ Pos.one)))))
def fourteen : Pos := plus seven seven
#check fourteen
#eval fourteen

-- so we can print strings
def Pos.toNat : Pos → Nat
  | Pos.one => 1
  | Pos.succ n => n.toNat + 1

instance : ToString Pos where
  toString x := toString (x.toNat)

#eval s!"There are {seven}"

-- this will let us use + (HAdd.hadd)
instance : Add Pos where
  add := Pos.plus

def eight : Pos := seven + Pos.one
#eval eight

-- same for * (HMul.hMul)
def Pos.mul : Pos → Pos → Pos
  | Pos.one, k => k
  | Pos.succ n, k => n.mul k + k

instance : Mul Pos where
  mul := Pos.mul

#eval [seven * Pos.one,
      seven * seven,
      Pos.succ Pos.one * seven]
