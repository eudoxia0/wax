For now this will be mostly a personal project, that I'm just posting on GitHub
in case the Gods of the Platters turn from me and I lose my local copy.

# Goals

- **Flexible:** Works for large projects like documentation or books, and for
  compiling a page in a blog.
- **Extensible:** Users can define macros within the system.

# Architecture

- Output is different for every **backend**. Currently supported backends are
  HTML and LaTeX.
- Wax consists of a series of **primitives**, tags that are guaranteed to map to
  something in the target.
- On top of the primitives, **macros** can be built to map one tag to the other,
  all the way down to the core language.

# Example


## Book

For a larger-scale example, look in the `examples/` directory.

# Reference

# License

Copyright (c) 2013 Fernando Borretti (eudoxiahp@gmail.com)

Licensed under the [LLGPL](http://opensource.franz.com/preamble.html) License.
