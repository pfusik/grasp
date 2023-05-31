(import (define-syntax-rule))
(import (assert))
(import (define-interface))
(import (define-type))
(import (define-object))
(import (define-property))
(import (define-cache))
(import (define-parameter))
(import (default-value))
(import (fundamental))
(import (infix))
(import (match))
(import (functions))
(import (for))
(import (while))
(import (pane))
(import (indexable))
(import (painter))
(import (print))
(import (extent))
(import (space))
(import (parse))
(import (conversions))
(import (cursor))
(import (editor-operations))
(import (input))
(import (android-keymap))
(import (postponed))
(import (touch-event-processor))
(import (history))
;;(import (primitive))
(import (extension))
(import (button))


(define-alias Bundle android.os.Bundle)
;;(define-alias KeyEvent android.view.KeyEvent)
(define-alias MotionEvent android.view.MotionEvent)
(define-alias Canvas android.graphics.Canvas)
(define-alias AndroidActivity android.app.Activity)
(define-alias AndroidView android.view.View)
(define-alias Paint android.graphics.Paint)

(define-alias Typeface android.graphics.Typeface)
(define-alias InputMethodManager
  android.view.inputmethod.InputMethodManager)
(define-alias Path2D android.graphics.Path)
(define-alias RectF android.graphics.RectF)
(define-alias AssetManager
  android.content.res.AssetManager)

(define-alias DisplayMetrics
  android.util.DisplayMetrics)
(define-alias Color android.graphics.Color)

(define-alias AndroidResources
  android.content.res.Resources)

(define-alias AndroidWindow
  android.view.Window)

(define-alias WindowInsets
  android.view.WindowInsets)

(define-alias SensorListener
  android.hardware.SensorListener)

(define-syntax-rule (Path (command args ...) ...)
  (let ((path ::Path2D (Path2D)))
    (invoke path 'command (as float args) ...)
    ...
    path))

(define (path-extent path::Path2D)::Extent
  (let ((rect ::RectF (RectF)))
    (path:computeBounds rect #t)
    (Extent width: (rect:width)
	    height: (rect:height))))

(define-type (Font face: Typeface
		   size: real))

(define (load-font name::string activity::AndroidActivity)
  ::Typeface
  (Typeface:createFromAsset (activity:getAssets) name))

(define-syntax define-initializer
  (syntax-rules (::)
    ((define-initializer (initializer-name
			  object-name::object-type)
       (definition name etc ... initialization)
       ...)
     (begin 
       (definition name etc ... #!null)
       ...
       (define (initializer-name object-name::object-type)
	 ::void
	 (set! name initialization)
	 ...)))))

(define the-view ::AndroidView #!null)

(define-object (EventCanceller action::java.lang.Runnable
			       sync::android.os.Handler)
  ::Cancellable
  (define (cancel)::Cancellable
    (sync:removeCallbacks action)
    cancellable-nothing))

(define-object (EventRunner sync::android.os.Handler
			    view::AndroidView)
  ::Postponed
  (define (after time-ms::long action::java.lang.Runnable)
    ::Cancellable
    (sync:postDelayed action time-ms)
    (view:invalidate)
    (EventCanceller action sync)))

(define-initializer (initialize-activity
		     activity::AndroidActivity)
  (define FiraMono ::Typeface
    (load-font "FiraMono-Medium.ttf" activity))
  
  (define BarlowCondensed
    (load-font "BarlowCondensed-Medium.ttf" activity))

  (define Crimson
    (load-font "Crimson-Roman.ttf" activity))
  
  (define Oswald-Regular ::Typeface
    (load-font "Oswald-Regular.ttf" activity))

  (define GloriaHallelujah ::Typeface
    (load-font "GloriaHallelujah.ttf" activity))

  (define NotoSerif-Regular ::Typeface
    (load-font "NotoSerif-Regular.ttf" activity))

  (define assets ((activity:getAssets):list ""))
  
  (define init-script
    (let* ((assets ::AssetManager (activity:getAssets))
	   (input (gnu.kawa.io.InPort
		   (java.io.InputStreamReader
		    (assets:open "init.scm")))))
      (safely (read-all input))))
  
  (define the-atom-font ::parameter[Font]
    (make-parameter
     (Font face: BarlowCondensed
	   size: 56)))

  (define the-string-font ::parameter[Font]
    (make-parameter
     (Font face: FiraMono
	   size: 32)))

  (define the-comment-font ::parameter[Font]
    (make-parameter
     (Font face: GloriaHallelujah
	   size: 28)))

  (define the-caption-font ::parameter[Font]
    (make-parameter
     (Font face: Oswald-Regular
	   size: 44)))
  
  (define the-block-comment-font ::parameter[Font]
    (make-parameter
     (Font face: Crimson ;;NotoSerif-Regular
	   size: 36)))

  (define the-block-comment-margin ::parameter[real]
    (make-parameter 10))
  
  (define the-log-font ::parameter[Font]
    (make-parameter
     (Font face: Oswald-Regular
	   size: 28)))

  (define the-cursor-offset ::parameter[Position]
    (make-parameter (Position left: 0 top: 32)))

  (define the-cursor-extent ::parameter[Extent]
    (make-parameter (Extent width: 2 height: 32)))

  (define parenthesis-color ::parameter[long]
    (make-parameter #xffcccccc))

  (define focused-parenthesis-color ::parameter[long]
    (make-parameter #xff555555))

  (define matching-parenthesis-color ::parameter[long]
    (make-parameter #xff888888))
  
  (define top-left-paren ::Path2D
    (Path
     (moveTo 0 50)
     (lineTo 0 20)
     (quadTo 0 0 20 0)
     (lineTo 20 10)
     (quadTo 10 10 10 20)
     (lineTo 10 50)
     (close)))

  (define top-left-extent ::Extent
    (path-extent top-left-paren))

  (define bottom-left-paren ::Path2D
    (Path
     (moveTo 0 0)
     (lineTo 0 30)
     (quadTo 0 50 20 50)
     (lineTo 20 40)
     (quadTo 10 40 10 30)
     (lineTo 10 0)
     (close)))

  (define bottom-left-extent ::Extent
    (path-extent bottom-left-paren))

  (define top-right-paren ::Path2D
    (Path
     (moveTo 0 0)
     (quadTo 20 0 20 20)
     (lineTo 20 50)
     (lineTo 10 50)
     (lineTo 10 20)
     (quadTo 10 10 0 10)
     (close)))

  (define top-right-extent ::Extent
    (path-extent top-right-paren))

  (define bottom-right-paren ::Path2D
    (Path
     (moveTo 20 0)
     (lineTo 20 30)
     (quadTo 20 50 0 50)
     (lineTo 0 40)
     (quadTo 10 40 10 30)
     (lineTo 10 0)
     (close)))

  (define bottom-right-extent ::Extent
    (path-extent bottom-right-paren))

  ;; quote

  (define top-left-quote-paren ::Path2D
    (Path
     (lineTo 20 0)
     (lineTo 20 10)
     (lineTo 10 10)
     (lineTo 10 50)
     (lineTo 0 50)
     (close)))

  (define top-left-quote-extent ::Extent
    (path-extent top-left-quote-paren))

  (define bottom-left-quote-paren ::Path2D
    (Path
     (lineTo 0 50)
     (lineTo 20 50)
     (lineTo 20 40)
     (lineTo 10 40)
     (lineTo 10 0)
     (close)))

  (define bottom-left-quote-extent ::Extent
    (path-extent bottom-left-quote-paren))

  (define top-right-quote-paren ::Path2D
    (Path
     (lineTo 20 0)
     (lineTo 20 50)
     (lineTo 10 50)
     (lineTo 10 10)
     (lineTo 0 10)
     (close)))

  (define top-right-quote-extent ::Extent
    (path-extent top-right-quote-paren))

  (define bottom-right-quote-paren ::Path2D
    (Path
     (moveTo 20 0)
     (lineTo 20 50)
     (lineTo 0 50)
     (lineTo 0 40)
     (lineTo 10 40)
     (lineTo 10 0)
     (close)))

  (define bottom-right-quote-extent ::Extent
    (path-extent bottom-right-quote-paren))

  (define quote-marker ::Path2D
    (Path
     (lineTo 10 0)
     (lineTo 10 50)
     (close)))

  (define quote-marker-extent ::Extent
    (path-extent quote-marker))

  (define single-quote ::Path2D
    (Path
     (moveTo 7.5 0)
     (quadTo 15 0 15 7.5)
     (quadTo 15 15 7.5 15)
     (quadTo 0 15 0 7.5)
     (quadTo 0 0 7.5 0)
     (close)

     (moveTo (+ 7.5 (* 0.5 7.5 (sqrt 2)))
	     (- 7.5 (* 0.5 7.5 (sqrt 2))))
     (quadTo 22.5 22.5 0 30)
     (quadTo 7.5 30 7.5 15)
     (close)
     ))

  (define single-quote-extent ::Extent
    (path-extent single-quote))

  )

(define (INFO . messages)
  (let ((result ::java.lang.StringBuilder
		(java.lang.StringBuilder)))
    (for message in messages
	 (result:append message))
  (android.util.Log:i "grasp-android" (result:toString))))

(define-early-constant paint ::Paint (Paint))

(define-early-constant transparent ::long #x00000000)

(define-early-constant ruler ::Paint (Paint))

(define (text-width text::CharSequence font::Font)::real
  (ruler:setTypeface font:face)
  (ruler:setTextSize font:size)
  (ruler:measureText text))

(define-object (ScreenLogger size)::MessageHandler

  (define (add-message message::list)::void
    (invoke-special logger (this) 'add-message message)
    (when the-view
      (the-view:invalidate)))
  
  (define (display-messages output::Object)::void
    (let* ((canvas ::Canvas (as Canvas output))
	   (font ::Font (the-log-font))
	   (top ::float  (- screen:extent:height
			    (* 4 font:size))))
      (paint:setTypeface font:face)
      (paint:setTextSize font:size)
      (for message in messages
	   (canvas:drawText message 0 top paint)
	   (set! top (- top font:size)))))

  (logger size))

(define-object (ShowKeyboardOnTap content::Pane view::View)

  (define (tap! finger::byte #;at x::real y::real)::boolean
    (and (invoke-special WrappedPane (this) 'tap! finger x y)
	 ;;(is (the-expression) Textual?)
	 (truly (view:showKeyboard))))

  (WrappedPane content))

(define-object (View source::AndroidActivity)::Painter
  
  (define canvas ::Canvas)

  (define activity ::AndroidActivity source)
  
  (define (showKeyboard)::void
    (when (requestFocus)
      (let ((imm ::InputMethodManager
		 (as InputMethodManager
		     (activity:getSystemService
		      android.content.Context:INPUT_METHOD_SERVICE))))
	(imm:showSoftInput (this)
			   InputMethodManager:SHOW_IMPLICIT))))

  (define clipLeft ::real 0)
  (define clipTop ::real 0)
  (define clipWidth ::real +inf.0)
  (define clipHeight ::real +inf.0)

  (define (clip! left::real  top::real
		 width::real height::real)
    ::void
    (canvas:clipRect (as float left) (as float top)
		     (as float (+ left width))
		     (as float (+ top height)))
    (set! clipLeft left)
    (set! clipTop top)
    (set! clipWidth width)
    (set! clipHeight height))
  
  (define (current-clip-width)::real
    clipWidth)
  
  (define (current-clip-height)::real
    clipHeight)
  
  (define (current-clip-left)::real
    clipLeft)
  
  (define (current-clip-top)::real
    clipTop)

  (define shiftLeft ::real 0)
  (define shiftTop ::real 0)

  (define (translate! x ::real y ::real)::void
    (canvas:translate x y)
    (set! shiftLeft (+ shiftLeft x))
    (set! shiftTop (+ shiftTop y)))
  
  (define (current-translation-left)::real
    shiftLeft)
  
  (define (current-translation-top)::real
    shiftTop)

  (define (horizontal-line-height)::real
    30)
  
  (define (vertical-line-width)::real
    30)

  (define text-color ::long #xff555555)

  (define background-color ::long transparent)
  
  (define (draw-horizontal-line! top::real)::void
    (let* ((left ::float (max 0 (current-clip-left)))
	   (bottom ::float (+ top (horizontal-line-height)))
	   (right ::float (+ left (current-clip-width))))
      (paint:setColor text-color)
      (canvas:drawRect left (as float top) right bottom
		       paint)))
  
  (define (draw-vertical-line! left::real)::void
    (let* ((top ::float (max 0 (current-clip-top)))
	   (right ::float (+ left (vertical-line-width)))
	   (bottom ::float (+ top (current-clip-height))))
      (paint:setColor text-color)
      (canvas:drawRect (as float left) top right bottom
		       paint)))

  (define (draw-line! x0::real y0::real x1::real y1::real)
    ::void
    (paint:setColor Color:LTGRAY)
    (paint:setStrokeWidth 4)
    (canvas:drawLine x0 y0 x1 y1 paint)
    (paint:setStrokeWidth 1))

  (define (draw-stroke! x0::real y0::real x1::real y1::real)
    ::void
    (draw-line! x0 y0 x1 y1))
  
  (define marked-cursor-position ::Position
    (Position left: 0
	      top: 0))
  
  (define (mark-cursor! +left::real +top::real)::void
    (let* ((cursor-extent (the-cursor-extent))
	   (cursor-offset (the-cursor-offset))
	   (left (+ +left cursor-offset:left))
	   (top (+ +top cursor-offset:top)))
      (set! marked-cursor-position:left
	    (+ (current-translation-left) +left))
      (set! marked-cursor-position:top
	    (+ (current-translation-top) +top))
      (paint:setColor text-color)
      (canvas:drawRect left top
		       (+ left cursor-extent:width)
		       (+ top cursor-extent:height)
		       paint)))
  
  (define (cursor-position)::Position
    marked-cursor-position)

  (define (cursor-height)::real
    (let ((offset ::Position (the-cursor-offset))
	  (extent ::Extent (the-cursor-extent)))
      (+ offset:top extent:height)))
  
  (define selection-drawing-mode? ::boolean #f)
  
  (define (enter-selection-drawing-mode!)::void
    (set! selection-drawing-mode? #t)
    (set! text-color #xffffffff)
    (set! background-color #xff555555))

  (define (exit-selection-drawing-mode!)::void
    (set! selection-drawing-mode? #f)
    (set! text-color #xff555555)
    (set! background-color transparent))

  (define (in-selection-drawing-mode?)::boolean
    selection-drawing-mode?)

  (define current-comment-level ::int 0)
  
  (define (enter-comment-drawing-mode!)::void
    (set! text-color #xffdddddd)
    (set! (parenthesis-color) #xffeeeeee)
    (set! atom-frame-color #xffeeeeee)
    (set! current-comment-level (+ current-comment-level 1)))
  
  (define (exit-comment-drawing-mode!)::void
    (set! current-comment-level (- current-comment-level 1))
    (when (is current-comment-level <= 0)
      (set! text-color #xff555555)
      (set! atom-frame-color #xffdddddd)
      (set! (parenthesis-color) #xffcccccc)))

  (define (in-comment-drawing-mode?)::boolean
    (is current-comment-level > 0))
  
  (define (clear!)::void
    (canvas:drawRGB 255 255 255))

  (define (vertical-bar-width)::real
    10)
  
  (define (horizontal-bar-height)::real
    10)
  
  (define (draw-horizontal-bar! width::real)::void
    (paint:setColor text-color)
    (canvas:drawRect 0 0 width (horizontal-bar-height) paint))
    
  (define (draw-vertical-bar! height::real)::void
    (paint:setColor text-color)
    (canvas:drawRect 0 0 (vertical-bar-width) height paint))

  (define (space-width)::real 16)

  (define (draw-rounded-rectangle! width::real height::real)
    ::void
    (paint:setColor text-color)
    (paint:setStyle Paint:Style:STROKE)
    (canvas:drawRoundRect 0 0 (as int width) (as int height)
			  10 10 paint)
    (paint:setStyle Paint:Style:FILL))

  (define (draw-rectangle! width::real height::real)::void
    (let ((b ::int 2))
      (paint:setColor text-color)
      (canvas:drawRect 0 0 (as int width) (as int b) paint)
      (canvas:drawRect 0 (as int (- height b))
		       (as int width) (as int height) paint)
      (canvas:drawRect 0 b b (as int (- height b)) paint)
      (canvas:drawRect (as int (- width b)) b
		       (as int width) (as int (- height b))
		       paint)
      ))
  
  (define (paren-width)::real
    (+ 1 top-left-extent:width))

  (define (min-line-height)::real
    (let ((font ::Font (the-atom-font)))
      font:size))
  
  (define (min-box-height)::real
    (let ((font ::Font (the-atom-font)))
      (max font:size
	   (+ top-left-extent:height
	      bottom-left-extent:height)
	   (+ top-right-extent:height
	      bottom-right-extent:height))))

  (define (open-paren! height::real color::long)::void
    (let ((line-height (max 0 (- height
				 top-left-extent:height
				 bottom-left-extent:height))))
      (paint:setColor color)
      (canvas:drawPath top-left-paren paint)
      (canvas:drawRect 0 top-left-extent:height
		       10 (+ top-left-extent:height
			     line-height)
		       paint)
      (with-translation (0 (+ top-left-extent:height
			      line-height))
	  (canvas:drawPath bottom-left-paren paint))))

  (define (close-paren! height::real color::long)::void
    (let ((line-height (max 0 (- height
				 top-right-extent:height
				 bottom-right-extent:height))))
      (paint:setColor color)
      (canvas:drawPath top-right-paren paint)
      (canvas:drawRect (- top-right-extent:width 10)
		       top-right-extent:height
		       top-right-extent:width
		       (+ top-right-extent:height line-height)
		       paint)

      (with-translation (0 (+ top-right-extent:height
			      line-height))
	  (canvas:drawPath bottom-right-paren paint))))

  (define (opening-parenthesis-color context::Cursor)::long
    (match (the-cursor)
      (`(#\[ . ,,context)
       (focused-parenthesis-color))
      (`(#\] . ,,context)
       (matching-parenthesis-color))
      (_
       (parenthesis-color))))

  (define (closing-parenthesis-color context::Cursor)::long
    (match (the-cursor)
      (`(#\] . ,,context)
       (focused-parenthesis-color))
      (`(#\[ . ,,context)
       (matching-parenthesis-color))
      (_
       (parenthesis-color))))

  (define (draw-box! width::real height::real
		     context::Cursor)
    ::void
    (open-paren! height (opening-parenthesis-color context))
    (with-translation ((- width (paren-width)) 0)
      (close-paren! height
		    (closing-parenthesis-color context))))

  (define (open-quote-paren! height::real color::long)::void
    (let ((line-height (max 0 (- height
				 top-left-extent:height
				 bottom-left-extent:height))))
      (paint:setColor color)
      (canvas:drawPath top-left-quote-paren paint)
      (canvas:drawRect 0 top-left-quote-extent:height
		       10 (+ top-left-quote-extent:height
			     line-height)
		       paint)
      (with-translation (0 (+ top-left-quote-extent:height
			      line-height))
	  (canvas:drawPath bottom-left-quote-paren paint))))

  (define (close-quote-paren! height::real color::long)::void
    (let ((line-height (max 0 (- height
				 top-right-extent:height
				 bottom-right-extent:height))))
      (paint:setColor color)
      (canvas:drawPath top-right-quote-paren paint)
      (canvas:drawRect (- top-right-quote-extent:width 10)
		       top-right-quote-extent:height
		       top-right-quote-extent:width
		       (+ top-right-quote-extent:height line-height)
		       paint)

      (with-translation (0 (+ top-right-quote-extent:height
			      line-height))
	  (canvas:drawPath bottom-right-quote-paren paint))))

  
  (define (draw-quote-box! width::real
			   height::real
			   context::Cursor)
    ::void
    (open-quote-paren! height (opening-parenthesis-color context))
    (with-translation ((- width (quote-paren-width)) 0)
      (close-quote-paren! height
			  (closing-parenthesis-color context))))
  
  (define (quote-paren-width)::real
    (+ 1 top-left-quote-extent:width))
  
  (define (draw-quote-markers! width::real
			       height::real
			       context::Cursor)
    ::void
    (paint:setColor (opening-parenthesis-color context))
    (canvas:drawPath quote-marker paint))

  (define (quote-marker-width)::real
    (+ 1 quote-marker-extent:width))

  (define (open-quasiquote-paren! height::real color::long)::void
    (let ((line-height (max 0 (- height top-left-extent:height))))
      (paint:setColor color)
      (canvas:drawPath top-left-quote-paren paint)
      (canvas:drawRect 0 top-left-quote-extent:height
		       10 (+ top-left-quote-extent:height
			     line-height)
		       paint)))

  (define (close-quasiquote-paren! height::real color::long)::void
    (let ((line-height (max 0 (- height top-right-extent:height))))
      (paint:setColor color)
      (canvas:drawPath top-right-quote-paren paint)
      (canvas:drawRect (- top-right-quote-extent:width 10)
		       top-right-quote-extent:height
		       top-right-quote-extent:width
		       (+ top-right-quote-extent:height line-height)
		       paint)))
  
  (define (draw-quasiquote-box! width::real
				height::real
				context::Cursor)
    ::void
    (open-quasiquote-paren! height
			    (opening-parenthesis-color context))
    (with-translation ((- width (quasiquote-paren-width)) 0)
      (close-quasiquote-paren! height
			       (closing-parenthesis-color context))))
  
  (define (quasiquote-paren-width)::real
    (+ 1 top-left-quote-extent:width))
  
  (define (draw-quasiquote-markers! width::real
				    height::real
				    context::Cursor)
    ::void
    (paint:setColor (opening-parenthesis-color context))
    (canvas:drawPath top-left-quote-paren paint)
    (with-translation ((+ width (quasiquote-marker-width)) 0)
      (paint:setColor (closing-parenthesis-color context))
      (canvas:drawPath top-right-quote-paren paint)))
  
  (define (quasiquote-marker-width)::real
    (+ 1 top-left-quote-extent:width))

  (define (open-unquote-paren! height::real color::long)::void
    (let ((line-height (max 0 (- height
				 bottom-left-quote-extent:height))))
      (paint:setColor color)
      (canvas:drawRect 0 0 10 line-height paint)
      (with-translation (0 line-height)
	(canvas:drawPath bottom-left-quote-paren paint))
      ))

  (define (close-unquote-paren! height::real color::long)::void
    (let ((line-height (max 0 (- height
				 bottom-right-quote-extent:height))))
      (paint:setColor color)
      (canvas:drawRect (- bottom-right-quote-extent:width 10) 0
		       bottom-right-quote-extent:width line-height
		       paint)
      (with-translation (0 line-height)
	(canvas:drawPath bottom-right-quote-paren paint))))
  
  (define (draw-unquote-box! width::real
			     height::real
			     context::Cursor)
    ::void
    (open-unquote-paren! height (opening-parenthesis-color context))
    (with-translation ((- width (quasiquote-paren-width)) 0)
      (close-unquote-paren! height
			    (closing-parenthesis-color context))))

  (define (unquote-paren-width)::real
    (+ 1 bottom-left-quote-extent:width))
    
  (define (draw-unquote-markers! width::real
				 height::real
				 context::Cursor)
    ::void
    (with-translation (0 (- height bottom-left-quote-extent:height))
      (paint:setColor (opening-parenthesis-color context))
      (canvas:drawPath bottom-left-quote-paren paint)
      (with-translation ((+ width (quasiquote-marker-width)) 0)
	(paint:setColor (closing-parenthesis-color context))
	(canvas:drawPath bottom-right-quote-paren paint))))
  
  (define (unquote-marker-width)::real
    (+ 1 bottom-left-quote-extent:width))

  (define (open-unquote-splicing-paren! height::real color::long)
    ::void
    (paint:setColor color)
    (canvas:drawRect 0 10 2.5 20 paint)
    (canvas:drawRect 5 10 10 20 paint)
    (with-translation (10 0)
      (open-unquote-paren! height color)))

  (define (close-unquote-splicing-paren! height::real color::long)
    ::void
    (paint:setColor color)
    (close-unquote-paren! height color)
    (canvas:drawRect 20 10 25 20 paint)
    (canvas:drawRect 27.5 10 30 20 paint))
  
  (define (draw-unquote-splicing-box!
	   width::real
	   height::real
	   context::Cursor)
    ::void
    (open-unquote-splicing-paren!
     height (opening-parenthesis-color context))
    (with-translation ((- width (unquote-splicing-paren-width)) 0)
      (close-unquote-splicing-paren!
       height (closing-parenthesis-color context))))

  (define (unquote-splicing-paren-width)::real
    (+ (unquote-paren-width) 10))

  (define (draw-unquote-splicing-markers!
	   width::real
	   height::real
	   context::Cursor)
    ::void
    (with-translation (0 (- height bottom-left-quote-extent:height))
      (paint:setColor (opening-parenthesis-color context))
      (canvas:drawRect 0 10 2.5 20 paint)
      (canvas:drawRect 5 10 10 20
		       paint)
      (with-translation (10 0)
	(canvas:drawPath bottom-left-quote-paren paint)      
	(with-translation ((+ width (quasiquote-marker-width)) 0)
	  (paint:setColor (closing-parenthesis-color context))
	  (canvas:drawPath bottom-right-quote-paren paint)
	  (canvas:drawRect 20 10 25 20 paint)
	  (canvas:drawRect 27.5 10 30 20 paint)))))

  (define (unquote-splicing-marker-width)::real
    (+ (unquote-marker-width) 10))

  (define (draw-text! text::CharSequence
		      font::Font
		      context::Cursor)
    ::void
    (let-values (((selection-start selection-end)
		  (the-selection)))
      (let* ((focused? (and (pair? (the-cursor))
			    (equal? context
				    (cdr (the-cursor)))))
	     (enters-selection-drawing-mode?
	      (and (pair? selection-start)
		   (equal? (cdr selection-start) context)))
	     (exits-selection-drawing-mode?
	      (and (pair? selection-end)
		   (equal? (cdr selection-end) context)))
	     (segment-start 0)
	     (left ::float 0)
	     (lines 1)
	     (height ::float font:size)
	     (string-end (text:length)))
	(parameterize ((the-cursor-extent (Extent
					   width: 2
					   height: height)))
	  (define (render-fragment! segment-end::int)
	    (let* ((fragment (text:subSequence segment-start
					       segment-end))
		   (width (text-width fragment font)))
	      (paint:setColor background-color)
	      (canvas:drawRect left (* (- lines 1) height)
			       (+ left width) (* lines height)
			       paint)
	      (paint:setColor text-color)
	      (canvas:drawText fragment left (* lines height)
			       paint)
	      (set! left (+ left width))))
	  
	  (paint:setTypeface font:face)
	  (paint:setTextSize font:size)
	  (for i from 0 below string-end
	       (when (and focused? (eqv? (car (the-cursor)) i))
		 (render-fragment! i)
		 (set! segment-start i)
		 (mark-cursor! left (* (- lines 1) height)))
	       
	       (when (and enters-selection-drawing-mode?
			  (eqv? (car selection-start) i))
		 (render-fragment! i)
		 (set! segment-start i)
		 (enter-selection-drawing-mode!))
	       
	       (when (and exits-selection-drawing-mode?
			  (eqv? (car selection-end) i))
		 (render-fragment! i)
		 (set! segment-start i)
		 (exit-selection-drawing-mode!))
	       
	       (when (eq? (text:charAt i) #\newline)
		 (render-fragment! i)
		 (set! left 0)
		 (set! lines (+ lines 1))
		 (set! segment-start (+ i 1))))
	  (render-fragment! string-end)
	  (when (and focused? (eqv? (car (the-cursor))
				    string-end))
	    (mark-cursor! left (* (- lines 1) height)))))))

  (define (draw-string! text::CharSequence context::Cursor)
    ::void
    (draw-text! text (the-string-font) context))

  (define quoted-text-cursor-offset::Position
    (Position left: -1 top: 2))
  
  (define (draw-quoted-text! text::CharSequence
			     context::Cursor)
    ::void
    (parameterize ((the-cursor-offset
		    quoted-text-cursor-offset))
      (canvas:drawPath single-quote paint)
      (with-translation (single-quote-extent:width 0)
	(canvas:drawPath single-quote paint)
	(with-translation (single-quote-extent:width
			   single-quote-extent:height)
	  (draw-string! text context)
	  (let ((extent ::Extent (text-extent text
					      (the-string-font))))
	    (with-translation (extent:width extent:height)
	      (canvas:drawPath single-quote paint)
	      (with-translation (single-quote-extent:width 0)
		(canvas:drawPath single-quote paint))))))))

  (define (quoted-text-extent text::CharSequence)::Extent
    (let ((inner ::Extent (text-extent text (the-string-font))))
      (Extent width: (+ inner:width
			(* 4 single-quote-extent:width))
	      height: (+ inner:height
			 (* 2 single-quote-extent:height)))))

  (define (quoted-text-character-index-under
	   x::real y::real text::CharSequence)
    ::int
    (text-character-index-under
     (- x (* 2 single-quote-extent:width))
     (- y single-quote-extent:height)
     text (the-string-font)))

  
  (define (text-extent text::CharSequence font::Font)::Extent
    (let* ((line-start 0)
	   (lines ::int 1)
	   (line-height ::float font:size)
	   (max-width 0)
	   (string-end (text:length)))
      (for i from 0 below string-end
	   (when (eq? (text:charAt i) #\newline)
	     (set! max-width
		   (max max-width
			(text-width (text:subSequence
				     line-start i)
				    font)))
	     (set! lines (+ lines 1))
	     (set! line-start (+ i 1))))
      (set! max-width
	(max max-width
		 (text-width
		  (text:subSequence line-start string-end)
		  font)))
      (Extent width: max-width
	      height: (* lines line-height))))

  (define (draw-caption! caption::CharSequence)::void
    (draw-text! caption (the-caption-font) #!null))

  (define (caption-extent caption::CharSequence)::Extent
    (text-extent caption (the-caption-font)))
  
  (define (caption-vertical-margin)::real
    (let* ((font ::Font (the-caption-font)))
      font:size))
      
  (define (caption-horizontal-margin)::real
    (caption-vertical-margin))
  
  (define (atom-extent text::CharSequence)::Extent
    (let ((painter ::Painter (the-painter))
	  (inner ::Extent (text-extent text (the-atom-font))))
      (Extent width: (+ inner:width 8)
	      height: (max (painter:min-box-height)
			   (+ inner:height 16)))))

  (define atom-cursor-offset::Position (Position left: 0
						 top: 4))

  (define atom-frame-color ::long #xffdddddd)

  (define (draw-atom! text::CharSequence context::Cursor)::void
    (let* ((font (the-atom-font))
	   (extent ::Extent (text-extent text font)))
      (paint:setColor atom-frame-color)
      (canvas:drawRoundRect (as int 0) (as int 28)
			    (as int (+ extent:width 8))
			    (as int (+ extent:height 16))
			    12 12 paint)
      (with-translation (4 16)
	(parameterize ((the-cursor-offset
			atom-cursor-offset))
	    (draw-text! text font context)))))
  
  (define (text-character-index-under x::real y::real
				      text::CharSequence
				      font::Font)
    ::int
    (let* ((line-height font:size)
	   (string-end (text:length)))
      (let loop ((i 0)
		 (left 0)
		 (top 0))
	(if (is i >= string-end)
	    (max 0 (- i 1))
	    (let ((c (text:charAt i)))
	      (match c
		(#\newline
		 (if (is top <= y < (+ top line-height))
		     i
		     (loop (+ i 1) 0 (+ top line-height))))
		(_
		 (let ((width (text-width (text:subSequence
					   i (+ i 1))
					  font)))
		   (if (and (is top <= y < (+ top line-height))
			    (is left <= x < (+ left width)))
		       i
		       (loop (+ i 1) (+ left width)
			     top))))))))))
  
  (define (atom-character-index-under x::real y::real
				      text::CharSequence)
    ::int
    (text-character-index-under x y text (the-atom-font)))
  
  (define (draw-line-comment! text::CharSequence
			      context::Cursor)
    ::void
    (draw-text! text (the-comment-font) context))
  
  (define (line-comment-extent text::CharSequence)
    ::Extent
    (text-extent text (the-comment-font)))
  
  (define (line-comment-character-index-under
	   x::real y::real text::CharSequence)
    ::int
    (text-character-index-under x y text (the-comment-font)))

  (define (draw-block-comment! text::CharSequence
			       context::Cursor)
    ::void
    (let* ((font ::Font (the-block-comment-font))
	   (outer ::Extent (block-comment-extent text))
	   (margin ::real (the-block-comment-margin)))
      (draw-rectangle! outer:width outer:height)
      (with-translation (margin (* 0.4 font:size))
	  (draw-text! text font context))))
  
  (define (block-comment-extent text::CharSequence)::Extent
    (let* ((font ::Font (the-block-comment-font))
	   (inner ::Extent (text-extent text font))
	   (margin ::real (the-block-comment-margin)))
      (Extent width: (+ inner:width margin margin)
	      height: (+ inner:height font:size))))
  
  (define (block-comment-character-index-under
	   x::real y::real text::CharSequence)
    ::int
    (let* ((font ::Font (the-block-comment-font))
	   (margin ::real (the-block-comment-margin)))
      (text-character-index-under (- x margin)
				  (- y (* 0.4 font:size))
				  text font)))
  
  (define (draw-point! left::real top::real aRGB::int)::void
    (let* ((alpha ::int
		  (- 255
		     (bitwise-and
		      #xff
		      (bitwise-arithmetic-shift aRGB -24))))
	   (red ::int (bitwise-and
		       #xff
		       (bitwise-arithmetic-shift aRGB -16)))
	   (green ::int (bitwise-and
			 #xff
			 (bitwise-arithmetic-shift aRGB -8)))
	   (blue ::int (bitwise-and #xff aRGB)))
      (paint:setColor (as int
			  (bitwise-ior
			   (bitwise-arithmetic-shift alpha 24)
			   (bitwise-arithmetic-shift red 16)
			   (bitwise-arithmetic-shift green 8)
			   blue)))
      (canvas:drawCircle left top 10.0 paint)))
  
  (define (onDraw c::Canvas)::void
    (set! canvas c)
    (clear!)
    (screen:draw!)
    (invoke (current-message-handler)
	    'display-messages canvas))
  
  (AndroidView source)
  (setFocusable #t)
  (setFocusableInTouchMode #t)
  ;;(setClickable #t)
  (paint:setFlags Paint:ANTI_ALIAS_FLAG))

(define-object (GRASP)

  (define view :: View)
  
  (define process-finger ::TouchEventProcessor[]
    (TouchEventProcessor[] length: 10))
  
  (define (invalidating result::boolean)::boolean
    (when result
      (view:invalidate))
    result)
  
  (define (onTouchEvent event::MotionEvent)::boolean
    (define (pointer-down? event-action::int)::boolean
      (or (eq? event-action MotionEvent:ACTION_DOWN)
	  (eq? event-action MotionEvent:ACTION_POINTER_DOWN)))

    (define (pointer-up? event-action::int)::boolean
      (or (eq? event-action MotionEvent:ACTION_UP)
	  (eq? event-action MotionEvent:ACTION_POINTER_UP)
	  (eq? event-action MotionEvent:ACTION_OUTSIDE)
	  (eq? event-action MotionEvent:ACTION_CANCEL)))
    (safely
     (invalidating
      (match (event:getActionMasked)
	(,@pointer-down?
	 (let* ((i ::int (event:getActionIndex))
		(p ::int (event:getPointerId i))
		(finger ::TouchEventProcessor
			(process-finger p)))
	   (finger:press! (- (event:getX i) (view:getLeft))
			  (- (event:getY i) (view:getTop))
			  (event:getEventTime))))
	(,@pointer-up?
	 (let* ((i ::int (event:getActionIndex))
		(p ::int (event:getPointerId i))
		(finger ::TouchEventProcessor
			(process-finger p)))
	   (finger:release! (- (event:getX i) (view:getLeft))
			    (- (event:getY i) (view:getTop))
			    (event:getEventTime))))
	(,MotionEvent:ACTION_MOVE
	 (let ((n ::int (event:getPointerCount))
	       (result ::boolean #f))

	   (for i from 0 below n
		(let* ((p ::int (event:getPointerId i))
		       (finger ::TouchEventProcessor
			       (process-finger p)))
		  (set! result
			(or (finger:move!
			     (- (event:getX i) (view:getLeft))
			     (- (event:getY i) (view:getTop))
			     (event:getEventTime))
			    result))))
	   result))
	(_
	 #f))
      )))
  
  (define (onKeyUp keyCode::int event::KeyEvent)::boolean
    #f)

  (define (onKeyDown keyCode::int event::KeyEvent)::boolean
    (safely
     (parameterize ((unicode-input (integer->char
				    (event:getUnicodeChar))))
       (invalidating
	(screen:key-typed!
	 (as long
	     (bitwise-ior
	      (as long keyCode)
	      (if (event:ctrl-pressed?) CTRL_MASK 0)
	      (if (event:alt-pressed?) ALT_MASK 0)
	      (if (event:shift-pressed?) SHIFT_MASK 0)
	      )))))))
  
  (define (onCreate savedState::Bundle)::void
    (invoke-special AndroidActivity (this) 'onCreate
		    savedState)
    (set! (current-message-handler) (ScreenLogger 10))
    (let ((scheme ::gnu.expr.Language
		  (or kawa.standard.Scheme:instance
		      (kawa.standard.Scheme))))
  
      (kawa.standard.Scheme:registerEnvironment)
      (gnu.mapping.Environment:setCurrent
       (scheme:getEnvironment)))

    (let* ((window ::AndroidWindow (invoke-special
				    AndroidActivity
				    (this) 'getWindow))
	   (decor ::AndroidView (window:getDecorView))
	   (flags ::int
		  (bitwise-ior 
		   #;AndroidView:SYSTEM_UI_FLAG_HIDE_NAVIGATION
		   AndroidView:SYSTEM_UI_FLAG_FULLSCREEN
		   AndroidView:SYSTEM_UI_FLAG_IMMERSIVE
		   )))
      (decor:setSystemUiVisibility flags))
    
    (initialize-activity (this))
    (safely (initialize-keymap))
    (set! view (View (this)))
    (set! the-view view)

    (let* ((resources ::AndroidResources (getResources))
	   (metrics ::DisplayMetrics
		    (resources:getDisplayMetrics)))
      (set! screen:extent:width metrics:widthPixels)
      (set! screen:extent:height metrics:heightPixels))

    (view:setSystemUiVisibility
     AndroidView:SYSTEM_UI_FLAG_FULLSCREEN)
    (view:setFitsSystemWindows #t)
    (setContentView view)
    
    (set! (the-painter) view)
    (for expression in init-script
      (safely
       (eval expression)))
    (set! screen:top
	  (ShowKeyboardOnTap screen:top view))
    (let ((postpone ::Postponed (EventRunner
				 (android.os.Handler)
				 view)))
      (for finger from 0 below 10
	   (set! (process-finger finger)
		 (TouchEventProcessor finger screen
				      postpone
				      vicinity: 15))))
    (WARN screen)
    )
  
  (AndroidActivity))
