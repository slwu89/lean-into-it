-- notes for sections 1.1 - 1.4

#eval 1 + 2
#eval 1 + 2 * 5

#eval String.append "Hello, " "Lean!"
#eval String.append "great " (String.append "oak " "tree")

#eval String.append "it is " (if 1 > 2 then "yes" else "no")

#eval 42+19
#eval String.append "A" (String.append "B" "C")
#eval String.append (String.append "A" "B") "C"
#eval if 3 == 3 then 5 else 7
#eval if 3 == 4 then "equal" else "not equal"

-- types
#eval (1+2 : Nat)

#eval 1-2
#eval (1-2 : Int)
#check (1-2 : Int)

-- functions/definitions
def hello := "Hello"
def lean : String := "Lean"

#eval String.append hello (String.append " " lean)

def add1 (n : Nat) : Nat := n + 1
#eval add1 7

def maximum (n : Nat) (k : Nat) : Nat :=
  if n < k then
    k
  else n

#eval maximum (5 + 8) (2 * 7)

-- just the function's signature
#check maximum

-- the type of the function
#check (maximum)

def joinStringsWith (s1 : String) (s2 : String) (s3 : String) :=
  String.append s2 (String.append s1 s3)

#eval joinStringsWith ", " "one" "and another"
#check (joinStringsWith)

def Str : Type := String
def aStr : Str := "This is a string."

-- structures
structure Point where
  x : Float
  y : Float
deriving Repr

def origin : Point := { x := 0.0, y := 0.0 }
#check origin
#eval origin

#eval origin.x
#eval origin.y

def addPoints (p1 : Point) (p2 : Point) : Point :=
  {x := p1.x + p2.x, y := p1.y + p2.y}

#eval addPoints origin {x:=1.324,y:=40.3}

def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt (((p2.x - p1.x) ^ 2.0) + ((p2.y - p1.y) ^ 2.0))

#eval distance { x := 1.0, y := 2.0 } { x := 5.0, y := -1.0 }

#check ({ x := 0.0, y := 0.0 } : Point)
#check { x := 1.23, y := 7.98 : Point}

def setX (p : Point) (x : Float) : Point :=
  { p with x := x }

#eval setX origin 2.543

#check Point.mk 1.5 2.8
#check ({x := 1.5, y := 2.8} : Point)

#check (Point.x)
#check (origin.x)

#eval origin.x
#eval Point.x origin

def Point.modifyBoth (f : Float → Float) (p : Point) : Point :=
  { x := f p.x, y := f p.y }

def fourAndThree : Point := { x := 4.435, y := 3.675 : Point }

#eval fourAndThree.modifyBoth Float.floor

-- exercises: Structures
structure RectangularPrism where
  height : Float
  width : Float
  depth : Float
deriving Repr

def RectangularPrism.volume (rp : RectangularPrism) : Float :=
  rp.depth * rp.width * rp.height

def MyRecPrism := { height := 1.32, width := 4.43, depth := 7.53 : RectangularPrism}
#eval MyRecPrism.volume
