-- notes for section 1.5

#check 5
#eval Nat.succ (Nat.succ (Nat.succ Nat.zero))

-- recall Nat is defined like this:
-- inductive Nat where
--   | zero : Nat
--   | succ (n : Nat) : Nat

def isZero (n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ k => false

-- destructuring means replacing *n* with the constructor code for it
-- for example
#eval 3 == Nat.succ (Nat.succ (Nat.succ Nat.zero))
#eval 3 == Nat.succ 2

-- lets make a function *pred* that is the opposite of *succ*
def pred (n : Nat) : Nat :=
  match n with
  | Nat.zero => Nat.zero
  | Nat.succ k => k

#eval pred 3
#eval pred 5436904506986
#eval pred 0

-- recursive functions
def even (n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ k => not (even k)

#eval even 0 -- true
#eval even 1 -- not (true)
#eval even 2 -- not (false) == not (not (true))

def plus (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => n
  | Nat.succ k' => Nat.succ (plus n k')

#eval plus 3 2
