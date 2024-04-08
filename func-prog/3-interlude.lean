theorem addAndAppend : (1 + 1 = 2) ∧ ("Str".append "ing" = "String") := by simp

def woodlandCritters : List String :=
  ["hedgehog", "deer", "snail"]

def hedgehog := woodlandCritters[0]
def deer := woodlandCritters[1]
def snail := woodlandCritters[2]

-- def oops := woodlandCritters[3]

def third (xs : List α) (ok : xs.length > 2) : α :=
  xs[2]
#eval third woodlandCritters (by simp)

def thirdOption (xs : List α) : Option α := xs[2]?
#eval thirdOption woodlandCritters

#eval thirdOption ["only", "two"]

-- exercise 1a
def Ex1a : 2 + 3 = 5 := rfl
#check Ex1a

def Ex1b : 15 - 8 = 7 := rfl
#check Ex1b

def Ex1c : "Hello, ".append "world" = "Hello, world" := rfl
#check Ex1c

-- def Ex1d : 5 < 18 := rfl
-- rfl doesn't work for this because rfl only applies
-- when two sides of the (in)equality statement
-- are already the same value; use simp

theorem Ex1d : 5 < 18 := by
  simp
#check Ex1d
