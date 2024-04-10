-- type classes (like interfaces in C++)

-- let's a positive numbers
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

-- how to use literal numbers for Pos (e.g. 5)
instance : OfNat Pos (n + 1) where
  ofNat :=
    let rec natPlusOne : Nat → Pos
    | 0 => Pos.one
    | k + 1 => Pos.succ (natPlusOne k)
  natPlusOne n

def eight : Pos := 8
#eval eight

-- this will let us use + (HAdd.hadd)
instance : Add Pos where
  add := Pos.plus

def nine : Pos := seven + Pos.one + Pos.one
#eval nine

-- same for * (HMul.hMul)
def Pos.mul : Pos → Pos → Pos
  | Pos.one, k => k
  | Pos.succ n, k => n.mul k + k

instance : Mul Pos where
  mul := Pos.mul

#eval [seven * Pos.one,
      seven * seven,
      Pos.succ Pos.one * seven]

-- exercises:

-- 1. do the Pos type but with a structure rather than inductive data type
structure Pos1 where
  succ ::
  pred : Nat
deriving Repr

def Pos1.Add (n k : Pos1) : Pos1 :=
  Pos1.succ (n.pred + k.pred + 1)

def myOne : Pos1 := {pred := 0}
def myTwo : Pos1 := {pred := 1}
def myThree : Pos1 := {pred := 2}

#eval Pos1.Add myOne myTwo
#eval Pos1.Add myTwo myThree

-- def Pos.plus (a b : Pos) : Pos := succ (a.pred + b.pred + 1)
