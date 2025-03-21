#let autores-init(body) = {
  let resrefs = state("resrefs", (:))
  let resref(id, display: false) = {
    resrefs.update(x => x + (repr(id): x.at(repr(id)) + 1))
    if display {ref(id)}
  }
}

#let autores(id: none, title: none, block-title: "", body) = {
  let display = if block-title != "" {block-title} else {smallcaps[Result]}
  show figure: it => {
    set align(start)
    set block(breakable: true, spacing: 2mm)
    it.body
  }

  resrefs.update(x => x + (repr(id): 0))
  [
    #figure(
      caption: none,
      kind: "result",
      supplement: display,
      outlined: false,
      context block(
        width: 100%,
        stroke: {
          let final = resrefs.final()
          let outputs = final.at(repr(id))
          let max-outputs = calc.max(final.values().sorted().last(), 1)
          let index = calc.floor(255 * (outputs/max-outputs))
          let col = color.map.mako.at(index)
          (
            left: 4pt + col,
            rest: 0.5pt + col
          )
        },
        inset: 2mm,
        outset: (left: 2pt),
        {
          display
          " "
          context counter(figure.where(kind: "result")).display()
          if title != none {" (" + title + ")"}
          ": "
          body
        }
      ),
    )#id
  ]
}
