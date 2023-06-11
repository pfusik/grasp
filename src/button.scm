(import (define-interface))
(import (define-type))
(import (define-object))
(import (extent))
(import (match))
(import (infix))
(import (functions))
(import (fundamental))
(import (indexable))
(import (painter))
(import (cursor))
(import (primitive))
(import (extension))
(import (print))
(import (for))
(import (while))

(define-object (ColumnGrid items::(sequence-of Enchanted))::Enchanted
  (define (extent)::Extent
    (let* ((painter ::Painter (the-painter))
           (grid-border ::real (painter:grid-border))
           (max-width ::real 0)
           (total-height ::real grid-border))
      (for item::Enchanted in items
        (let ((inner ::Extent (item:extent)))
          (set! max-width (max max-width inner:width))
	  (set! total-height
	        (+ total-height inner:height grid-border))))
      (Extent width: (+ max-width (* 2 grid-border))
              height: total-height)))
	      
  (define (draw! context::Cursor)::void
    (let* ((painter ::Painter (the-painter))
           (grid-border ::real (painter:grid-border))
	   (total ::Extent (extent))
           (n ::int 0)
           (x0 ::real (painter:current-translation-left))
	   (y0 ::real (painter:current-translation-top)))
      (for item::Enchanted in items
        (let ((inner ::Extent (item:extent)))
	  (painter:draw-horizontal-grid! (+ total:width
					    (* 2 grid-border)))
	  (painter:draw-vertical-grid! (+ inner:height
					  (* 2 grid-border)))
	  (with-translation (grid-border grid-border)
            (item:draw! (recons n context)))
	  (with-translation ((+ total:width grid-border) 0)
	    (painter:draw-vertical-grid! (+ inner:height
					    (* 2 grid-border))))
	  (painter:translate! 0 (+ grid-border inner:height))
	  (set! n (+ n 1))))
      (painter:draw-horizontal-grid! (+ total:width
					(* 2 grid-border)))
      (painter:translate!
       (- (painter:current-translation-left) x0)
       (- (painter:current-translation-top) y0))))
  
  (define (propagate finger::byte x::real y::real
                     action::(maps (Enchanted byte real real int)
				   to: Object))
    (let* ((painter ::Painter (the-painter))
           (grid-border ::real (painter:grid-border))
	   (ceiling ::real grid-border)
	   (n ::real 0))
      (call/cc
       (lambda (return)
         (for item::Enchanted in items
           (let ((inner ::Extent (item:extent)))
	     (when (is ceiling < y < (+ ceiling inner:height))
	       (return (action item finger
	                       (- x grid-border) (- y ceiling))))
	     (set! ceiling (+ inner:height grid-border))
	     (set! n (+ n 1))))
	 #f))))

  (define (part-at index::Index)::Indexable*
    (items index))

  (define (first-index)::Index 0)
  (define (last-index)::Index (- (length items) 1))
  
  (define (next-index index::Index)::Index
    (min (+ index 1) (last-index)))
    
  (define (previous-index index::Index)::Index
    (max 0 (- index 1)))
  
  (define (index< a::Index b::Index)::boolean
    (is a < b))
  
  (define (cursor-under* x::real y::real path::Cursor)::Cursor*
    (otherwise #!null
      (propagate 0 x y
		 (lambda (item::Enchanted
			  finger::byte
			  x::real y::real
			  index::int)
		   ::boolean
		   (item:cursor-under* x y (recons index path))))))

  (define (tap! finger::byte #;at x::real y::real)::boolean
    (propagate finger x y
	       (lambda (child::Enchanted
			finger::byte
			x::real y::real
			index::int)
		 ::boolean
		 (child:tap! finger x y))))

  (define (press! finger::byte #;at x::real y::real)::boolean
    (propagate finger x y
	       (lambda (child::Enchanted
			finger::byte
			x::real y::real
			index::int)
		 ::boolean
		 (child:press! finger x y))))
  
  (define (second-press! finger::byte #;at x::real y::real)::boolean
    (propagate finger x y
	       (lambda (child::Enchanted
			finger::byte
			x::real y::real
			index::int)
		 ::boolean
		 (child:second-press! finger x y))))
  
  (define (double-tap! finger::byte x::real y::real)::boolean
    (propagate finger x y
	       (lambda (child::Enchanted
			finger::byte
			x::real y::real
			index::int)
		 ::boolean
		 (child:double-tap! finger x y))))

  (define (long-press! finger::byte x::real y::real)::boolean
    (propagate finger x y
	       (lambda (child::Enchanted
			finger::byte
			x::real y::real
			index::int)
		 ::boolean
		 (child:long-press! finger x y))))

  (define (key-typed! key-code::long)::boolean
    ;; na razie tego nie obslugujemy; docelowo warto by bylo
    ;; przemyslec obsluge klawiatury
    #f)

  (define (as-expression)
    (fold-left (lambda (l x)
		 (set-cdr! l (cons (to-expression x) '()))
		 (cdr l))
	       (cons (Atom "ColumnGrid") '())
	       items))
  )
  
(define-type (Button action: (maps () to: void)
		     label: string)
  extending Magic
  with
  ((draw! context::Cursor)::void
   (let* ((painter ::Painter (the-painter))
	  (inner ::Extent (painter:caption-extent label))
	  (horizontal-margin ::real
			     (painter:caption-horizontal-margin))
	  (vertical-margin ::real
			   (painter:caption-vertical-margin)))
    (painter:draw-rounded-rectangle!
      (+ inner:width (* horizontal-margin 2))
      (+ inner:height (* vertical-margin 2)))
    (with-translation (horizontal-margin vertical-margin)
      (painter:draw-caption! label))))

  ((as-expression)::cons
   (origin (this)))
  
  ((extent)::Extent
   (let* ((painter ::Painter (the-painter))
	  (inner ::Extent (painter:caption-extent label))
	  (horizontal-margin ::real
			     (painter:caption-horizontal-margin))
	  (vertical-margin ::real
			   (painter:caption-vertical-margin)))

     (Extent width: (+ inner:width (* horizontal-margin 2))
	     height: (+ inner:height (* vertical-margin 2)))))

  ((key-pressed key::char)::boolean
   (cond ((eq? key #\newline)
	  (action)
	  #t)
	 (else
	  #f)))

  ((press! finger::byte x::real y::real)::boolean
   #t)
  
  ((tap! finger::byte x::real y::real)::boolean
   (action)
   #t))

(set! (extension 'Button)
      (object (Extension)
	((enchant source::cons)::Enchanted
	 (try-catch
	  (or (as Button (eval source)) #!null)
	  (ex java.lang.Throwable
	      (WARN "Unable to create Button from "source": "
		    (java.lang.String:valueOf ex))
	      #!null)))))
