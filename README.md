# Wax: Markup semantics for XML

Lightweight markup languages like Markdown work for simple documents, like this
README, because they have syntactic sugar for 80% of what one requires for
documentation. But fall apart when you want to add new features: What can I do
if I want tables? Or references? Or just a simple macro to reduce repetition? In
those cases you depend on non-standard extensions.

XML is not as easy on the eyes as Markdown, but it captures the essence of
markup: *Bring annotated text into an abstract representation, where it can be
manipulated however a programmer wants*. This is the goal of Wax.

Wax is a system for writing. You write in XML, and Wax converts that to HTML or
LaTeX. Or any other target you want.

Why XML, which is so nineties, and not a custom pseudo-TeX format like what
Scribble uses, or a pretentious pseudo-S-expression representation no editor
will support? Because XML works, and every editor closes tags anyway.

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

## Standalone file

A standalone `.wax` file can be used for whatever else you'd use, say, Markdown
or Textile for. For example, the following file, `example.wax`:

```xml
<page title="Example">
  <sec>Introduction</sec>

  Morning schedule:
  <olist>
    <item>Get up.</item>
    <item>Get dressed.</item>
    <item>Have breakfast.</item>
    <item>Shower.</item>
  </olist>
</page>
```

Can be compiled to standalone HTML file with `wax example.wax`.

## Book

For a larger-scale example, look in the `examples/` directory.

# Reference

## Root

The root element determines what kind of file is going to be processed.

### `page`

The `page` tag is the most generic root. It has a title 

## Extra Data Block

## Reference

### Basics

`b` and `i` are bold and italics, respectively. `quote` encodes a quote (A
`blockquote` in HTML).

### Sections

#### `sec`, `sec2`, `sec3`, `sec4`

Defines sections. `sec` is the greatest, `sec4` the smallest.

Can optionally have an `id`.

### Lists

`list` creates an unordered list, `olist` an ordered one, and each item is
marked with `item`.

Examples:

```xml
<olist>
  <item>Get up.</item>
  <item>Get dressed.</item>
  <item>Have breakfast.</item>
  <item>Shower.</item>
</olist>
```

### Links

#### `l`

There are two basic ways to do hyperlinks: The first is where the link URI is in
the link itself: `<l uri="https://www.google.com/">text</l>`. The other is where
the link simply has an ID that points to a link defined in a `baselink` element.

```xml
As explained by <l id="xkcd">xkcd</l>...

...

<baselink id="xkcd" uri="http://xkcd.com/1179/"/>
```

### References

A reference is declared with the `r` tag, and points to the text of the
reference with an `id`. Then, the `references` tag is used to store the text of
the references themselves.

Each reference can contain four attributes: `title`, `author`, `link` and
`desc`.

Example:

```xml
... was presented by Pellegrino in the essay "Relativistic robots and the
feasibility of interstellar flight"<r id="relrob"/>.

...

<references>
  <ref id="relrob">
    <title>Relativistic robots and the feasibility of interstellar flight</title>
    <author>Charles R. Pellegrino</author>
    <link>https://web.archive.org/web/20111116172452/http://www.charlespellegrino.com/propulsion.htm</link>
    <desc>The essay has since been taken down and redirects to the related essay
    <i>These New Oceans</i>, so a link to the Internet archive is
    provided</desc>
  </ref>
</references>
```

#### `cite`

The cite macro encapsulates this common pattern:

```xml
... <i>Work Title</i><ref id="work"/> ...
```

You can simply do:

```xml
... <cite id="work">Work Title</cite> ...
```

### External Interfaces

#### `include`

Includes the contents of a file, optionally only a subset of it.

Example:

```xml
<!-- Include the whole file -->
<include uri="file.txt"/>
<!-- Include from line 5 to the end-->
<include uri="file.txt" start="5"/>
<!-- Include from lines 3 to 14 -->
<include uri="file.txt" start="3" end="14"/>
```

#### `shell`

Runs a shell command, with the content in the tag as the `stdin`, and replaces
itself with the `stdout`.

Example:

```xml
<shell>
  <cmd>some-command ...</cmd>
  <args>...</args>
</shell>
```

# License

Copyright (c) 2013 Fernando Borretti (eudoxiahp@gmail.com)

Licensed under the [LLGPL](http://opensource.franz.com/preamble.html) License.
