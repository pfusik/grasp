;; -*- mode: scheme; *preserve-trailing-whitespace*: t -*-

(import
 (language define-syntax-rule)
 (language define-interface)
 (language define-type)
 (language define-object)
 (utils conversions)
 (editor interfaces painting)
 (editor interfaces elements)
 (editor types spaces)
 (editor document cursor)
 (editor types primitive)
 (editor text-painter)
 
 (editor types extensions extensions)
 (editor types extensions combinators)
 (editor document parse)
 (language examples)
 (language assert)
 (language infix)
 (language match)
 (language while)
 (utils functions)
 (utils print)
 (utils hash-table)
 (language for)
 (editor document document-operations)
 (editor document editor-operations)
 (editor document history-tracking)
 (editor interfaces painting)
 (editor text-painter)
 (editor document documents)

 (utils test)
 (editor types extensions widgets)
 (editor types extensions visual-stepper)
 )

(parameterize  ((the-document (call-with-input-string
				  "" parse-document))
		(the-cursor (cursor 0 0 1)))
  (for-each insert-character! "[1 ")
  (e.g. (snapshot) ===> "
╭    ╮
│ 1  │
╰   |╯
")
  (e.g. (the-cursor) ===> (1 2 1 1))
  (delete-backward!)
  (e.g. (snapshot) ===> "
╭   ╮
│ 1 │
╰  |╯
")
  (e.g. (the-cursor) ===> (0 2 1 1)) 
  )

(parameterize  ((the-document (call-with-input-string
				  "" parse-document))
		(the-cursor (cursor 0 0 1)))
  (for-each insert-character! "[Button label: \"button")
  (times 2 move-cursor-right!)
  (for-each insert-character! " action: nothing]") 
  (e.g. (snapshot) ===> "
╭               ❝┈┈┈┈┈┈┈┈•                 ╮
│ Button label: ┊ button ┊ action: nothing │
╰               •┈┈┈┈┈┈┈┈❞                 ╯
")
  (delete-backward!)
  (e.g. (snapshot) ===> "
")
  (undo!)
  (e.g. (snapshot) ===> "
╭               ❝┈┈┈┈┈┈┈┈•                 ╮
│ Button label: ┊ button ┊ action: nothing │
╰               •┈┈┈┈┈┈┈┈❞                |╯
")
  (perform&record! (EnchantExpression))
  (e.g. (snapshot) ===> "
╭────────╮
│ button │
╰────────╯
")
  (perform&record! (DisenchantExpression))
  (e.g. (snapshot) ===> "
╭               ❝┈┈┈┈┈┈┈┈•                 ╮
│ Button label: ┊ button ┊ action: nothing │
╰               •┈┈┈┈┈┈┈┈❞                 ╯
")
  (undo!)
  (e.g. (snapshot) ===> "
╭────────╮
│ button │
╰────────╯
")
  (delete-backward!)
  (e.g. (snapshot) ===> "
")
  (undo!)
  (move-cursor-right!)
  (e.g. (snapshot) ===> "
╭────────╮ 
│ button │ 
╰────────╯|
")
  (delete-backward!)
  (e.g. (snapshot) ===> "
")
  )

(parameterize  ((the-document (call-with-input-string
				  "" parse-document))
		(the-cursor (cursor 0 0 1)))
  (for-each insert-character! "(Stepper (+ (* 2 3) (- 4 5)))")
  (e.g. (snapshot) ===> "
╭         ╭   ╭       ╮ ╭       ╮ ╮ ╮
│ Stepper │ + │ * 2 3 │ │ - 4 5 │ │ │
╰         ╰   ╰       ╯ ╰       ╯ ╯ ╯
")
  
  (perform&record! (EnchantExpression))

  ;; the content isn't visually aligned particularly well
  ;; and should probably be fixed some day
  (e.g. (snapshot) ===> "
╔═══════════════════════════════════╗
║╭  ╭       ╮ ╭       ╮  ╮          ║
║│+ │ * 2 3 │ │ - 4 5 │  │          ║
║╰  ╰       ╯ ╰       ╯  ╯          ║
║╭─────╮╭─────╮╭─────╮╭─────╮╭─────╮║
║│ ▮◀◀ ││ ▮◀  ││  ▶  ││  ▶▮ ││ ▶▶▮ │║
║╰─────╯╰─────╯╰─────╯╰─────╯╰─────╯║
╚═══════════════════════════════════╝
")
  (move-cursor-right!)
  (delete-backward!)
  (e.g. (snapshot) ===> "
")
  (undo!)
  (e.g. (snapshot) ===> "
╔═══════════════════════════════════╗
║╭  ╭       ╮ ╭       ╮  ╮          ║
║│+ │ * 2 3 │ │ - 4 5 │  │          ║
║╰  ╰       ╯ ╰       ╯  ╯          ║
║╭─────╮╭─────╮╭─────╮╭─────╮╭─────╮║
║│ ▮◀◀ ││ ▮◀  ││  ▶  ││  ▶▮ ││ ▶▶▮ │║
║╰─────╯╰─────╯╰─────╯╰─────╯╰─────╯║
╚═══════════════════════════════════╝
")
  (perform&record! (DisenchantExpression
		    at: (suffix-without (isnt _ integer?)
					(the-cursor))))
  (e.g. (snapshot) ===> "
╭         ╭   ╭       ╮ ╭       ╮ ╮ ╮
│ Stepper │ + │ * 2 3 │ │ - 4 5 │ │ │
╰         ╰   ╰       ╯ ╰       ╯ ╯ ╯
")
  (undo!)
  (e.g. (snapshot) ===> "
╔═══════════════════════════════════╗
║╭  ╭       ╮ ╭       ╮  ╮          ║
║│+ │ * 2 3 │ │ - 4 5 │  │          ║
║╰  ╰       ╯ ╰       ╯  ╯          ║
║╭─────╮╭─────╮╭─────╮╭─────╮╭─────╮║
║│ ▮◀◀ ││ ▮◀  ││  ▶  ││  ▶▮ ││ ▶▶▮ │║
║╰─────╯╰─────╯╰─────╯╰─────╯╰─────╯║
╚═══════════════════════════════════╝
")
  )
