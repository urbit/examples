---
title: Structures
---

# Structures

A Hoon structure is simply one or several cores defining any number of molds. Keeping structures in one place allows for them to be used in multiple places, like apps, app marks and app libraries (see `:mesh` as a good example of this).

You'll see the following syntax in an app, mark or library when declaring to import a structure file via `%ford`:

    /-  name

Note the two spaces between the `/-` and the file name; the `%ford` rune here uses tall form. A structure file within a folder will use the syntax:

   /-  folder-name

If the structure file contains only a single, unarmed mold (see `/sur/mail/message`), you can simply use the structure file name to reference the single mold. However, if the structure is a core and you wish to use one of the mold arms within the core, in your code you must first evaluate the core and then specify the arm within that. You can use the irregular syntax for the [rap](https://urbit.org/docs/hoon/twig/tis-flow/gal-rap/) rune to do exactly this. An example would be accessing the `++friend` mold within `/sur/mesh` with the syntax `friend:mesh`. However, as you can see in the `:mesh` app code, a cleaner alternative is to simply add the `/sur/mesh` core to your subject with the syntax at the top of the file:

    /-  mesh
    [. mesh]

Then, all of the arms within that core are accessible directly in the app code, which gets evaluated against this new subject.
