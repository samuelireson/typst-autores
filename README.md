# AutoRes
`autores` is a [Typst](https://typst.app) package for tracking the importance
of mathematical (or other) results in your document.

## Motivation
This package started with the aim to unify theorem environments into a single
callable environment `autores` able to determine the naming of the result from
the context of the document. This would be beneficial in the way that the
importance of a given result would be determined definitively by the content of
the document in which it was situated. Results would be more portable between
documents since they would present themselves in a way which was reasonable in
all occurrences.

There are some difficulties in making this a reality since the naming of
mathematical results is an intricate process and largely down to the taste of
the author, so instead `autores` results will colour themselves based on their
importance in the current document.

## Usage

> Note: `autores` is not yet in the [universe](https://typst.app/universe) so
> you will have to use a local copy!

```typst
#import "@local/autores:0.0.1": autores, resref

#autores(id: <topological-space>, title: "Topological space")[
    Herein lies the definition of a topological space.
]

#autores(id: <hausdorff>, title: "Topological space")[
    A topological space#resref(<topological-space>) is Hausdorf if...
]
```

If you choose to reference an `autores` environment in text, then you can use
`#resref(<id>, display: true)`.

## Customisation

By default, `autores` will name all environments as `Result`. You can change this by defining specific environments as follows,

```typst
#import "@local/autores:0.0.1": autores

let definition = autores.with(block-title: "Definition")
```

You can also customise the colour scheme which is used with,

```typst
#import "@local/autores:0.0.1": autores-init

#show: autores-init(colour-scheme: color.map.crest
```

## Plans

- [] Add option for colour-scheme steps.
- [] Add option for scoping results to sections.
- [] Add ability to resolve dependencies from result.
- [] Determine theorem naming from dependents and dependencies.
