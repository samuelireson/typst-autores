#let resrefs = state("resrefs", (:))
#let curres = state("curres", none)
#let rescol = state("rescol", (:))
#let resref(id, display: false) = context {
  let dependent-id = curres.get()
  resrefs.update(x => {
    let curdeps = x.at(repr(dependent-id), default: ())
    let newdep = repr(id)
    let deps = curdeps + (newdep,)
    let resref-entry = (repr(dependent-id): deps)
    x + resref-entry
  })
	let col = rescol.get().at(repr(id))
  if display {box(inset: (x: 0.25em), outset: (y: 0.2em), radius: 0.2em, fill: col, text(fill: white, ref(id)))}
}

#let proof(body) = if not sys.inputs.keys().contains("hide-proof") {
  block(
    width: 100%,
    inset: 2mm,
    {
      emph[Proof. ]
      body
      align(right, sym.ballot)
    },
  )
}

#let autores(id: none, title: none, block-title: "", body) = context {
  let final = resrefs.final()
  let dependencies = final.at(repr(id), default: ()).len()
  let dependents = final.values().flatten().filter(x => x == repr(id)).len()
	let index = calc.floor(255 * (calc.min(dependents, 12) / 12))
	let col = color.map.flare.at(index)
	rescol.update(x => x + (repr(id): col))

  let display = if block-title != "" {block-title}
  // else if dependencies == 0 [Definition]
  // else if dependencies == 1 and dependents == 0 [Corollary]
  else [Result]

  show figure.where(kind: "result"): it => {
    set align(start)
    it.body
  }

  curres.update(id)
  [
    #figure(
      caption: none,
      kind: "result",
      supplement: smallcaps(display),
      outlined: false,
      context block(
				breakable: true,
				spacing: 2mm,
        width: 100%,
        stroke: {
          (
            left: 4pt + col,
            rest: 0.5pt + col
          )
        },
        inset: 2mm,
        outset: (left: 2pt),
        {
					set block(spacing: auto)
          smallcaps(display)
          " "
          counter(figure.where(kind: "result")).display()
          if title != none {" (" + title + ")"}
          ": "
          body
        }
      ),
    )#id
  ]
  curres.update(none)
}

#autores(id: <0>, title: "Graph")[
	This is another definition which is a dependency.
]

#autores(id: <1>, title: "Metagraph")[
	This is a definition which is independent.
]

#autores(id: <2>, title: "Metacategory")[
	This is a definition which is dependent on #resref(<1>, display: true) and #resref(<0>, display: true)
]

If we look at #resref(<2>, display: true), we can see that there is a dependence on #resref(<1>, display: true). Dependencies do not have to be visible in the document, for example this sentence may be dependent#resref(<1>) on the first result, without a reference.
