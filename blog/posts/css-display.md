# CSS `display`

CSS is being updated in the possibly-not-so-near-future with a plethora of new values.





## Possible values
This will be one of:
- both or either of:
  - a *display outside* value:
    - `block`
    - `inline`
    - `run-in`
  - a *display inside* value:
    - `flow`
    - `flow-root`
    - `table`
    - `flex`
    - `grid`
    - `ruby`
- or any one of:
  - a *display list* value:
    - `list-item`
  - a *display internal* value:
    - `table-row-group`
    - `table-header-group`
    - `table-footer-group`
    - `table-row`
    - `table-cell`
    - `table-column-group`
    - `table-column`
    - `table-caption`
    - `ruby-base`
    - `ruby-text`
    - `ruby-base-container`
    - `ruby-text-container`
  - a *display box* value:
    - `contents`
    - `none`
  - a *display legacy* value:
    - `inline-block`
    - `inline-list-item`
    - `inline-table`
    - `inline-flex`
    - `inline-grid`





## Use cases

This breaks up the way that we currently use values like `inline-block`
  into `block inline`… or `inline block`.\
Legacy values like `inline-block` will likely be supported for th forseeable future
  but using the new values, when they're available,
  will keep legacy values looking like new values.







### `run-in`

The thing that stood out most for me here is `run-in`.\
Not heard of it?
I don't blame you. It's new. And not well supported.\
The main use-case seems to be to allow headings to
  become part of the following paragraph text.
  
That is, if a heading is followed by another block element,
  ie: `<h1 display="run-in">heading<h1><p>paragraph</p>`
  it would behave as if it was the first child of that
  following block, and as if it was `display: inline`.
  However, if it is followed by an element with any other display value
  it would take on `display: block`
  and not insert itself into the following element.

That is, it would make something like this:\
**Heading**\
Paragraph paragraph.

Look like this:\
**Heading** Paragraph paragraph.







### `contents`

`display: contents;`, on the other hand, is fan*tas*tsic, and
  [browsers have already started implementing it](https://caniuse.com/#feat=css-display-contents).\
I only mentioned this one second because it's better known,
  ([and has issues with accessibility](https://hiddedevries.nl/en/blog/2018-04-21-more-accessible-markup-with-display-contents)).\
Basically put, using `display: contents` on an element removes it from the DOM,
  now only `display`ing its `contents`.

This is a real boon for those using markup created in suboptimal situations
  which feel the need to add markup all over the place.\
Things like `display: grid` parents can now have better control over their children,
  hiding any extrenuous ones that would otherwise prevent them from
  being a direct child.
