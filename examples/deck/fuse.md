# Stopping on an explicit contradiction

[fuse.n3](https://github.com/eyereasoner/eyeron/blob/main/examples/fuse.n3) · [output](https://github.com/eyereasoner/eyeron/blob/main/examples/output/fuse.n3) · [try it in the playground](https://eyereasoner.github.io/eyeron/playground#example=fuse)

---

## The question

One stone is described as both black and white. An N3 rule concludes false
when it finds that combination, causing an inference fuse to stop the run.

**What happens when the stone is both black and white under this rulebook?**

---

## What we tell Eyeron

The following excerpts use the prefixes declared in the linked source.
These are excerpts; the linked file contains the complete program.

```n3
# Both colour facts are deliberately supplied for the same stone.
:stone :color :black .

# This combination trips the inference fuse. The command exits with code 65.
{
    ?X :color :black .
    ?X :color :white .
} => false .
```

`{ … } => { … }` reads “when the left side holds, conclude the right side.”
Names beginning with `?` are variables: they stand for the values that make
the conditions match.

---

## What Eyeron concludes

There are no conclusions in the saved output. The program stops when its inference fuse trips:

```text
# Inference fuse triggered.
# Fired rule:
#   {
#     ?X :color :black .
#     ?X :color :white .
#   } => false .
# Matched instance:
#   {
#     :stone :color :black .
#     :stone :color :white .
#   } => false .
```

---

## Try it

```sh
eyeron examples/fuse.n3
```

---

## Takeaway

An explicit false conclusion stops inference with the specified halt status.
