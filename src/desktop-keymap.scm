(import (input))
(define-alias KeyEvent java.awt.event.KeyEvent)

(define (initialize-keymap)
  (set! (key-code-name KeyEvent:VK_ACCEPT) 'accept)
  (set! (key-code-name KeyEvent:VK_ADD) 'add)
  (set! (key-code-name KeyEvent:VK_AGAIN) 'again)
  (set! (key-code-name KeyEvent:VK_ALL_CANDIDATES) 'all-candidates)
  (set! (key-code-name KeyEvent:VK_ALPHANUMERIC) 'alphanumeric)
  (set! (key-code-name KeyEvent:VK_BEGIN) 'begin)
  (set! (key-code-name KeyEvent:VK_CANCEL) 'cancel)
  (set! (key-code-name KeyEvent:VK_CODE_INPUT) 'code-input)
  (set! (key-code-name KeyEvent:VK_COMPOSE) 'compose)
  (set! (key-code-name KeyEvent:VK_CONTEXT_MENU) 'context-menu)
  (set! (key-code-name KeyEvent:VK_CONVERT) 'convert)
  (set! (key-code-name KeyEvent:VK_COPY) 'copy)
  (set! (key-code-name KeyEvent:VK_CUT) 'cut)
  (set! (key-code-name KeyEvent:VK_PASTE) 'paste)
  (set! (key-code-name KeyEvent:VK_UNDO) 'undo)

  (set! (key-code-name KeyEvent:VK_DEAD_ABOVEDOT) 'dead-above-dot)
  (set! (key-code-name KeyEvent:VK_DEAD_ABOVERING) 'dead-above-ring)
  (set! (key-code-name KeyEvent:VK_DEAD_ACUTE) 'dead-acute)
  (set! (key-code-name KeyEvent:VK_DEAD_BREVE) 'dead-breve)
  (set! (key-code-name KeyEvent:VK_DEAD_CARON) 'dead-caron)
  (set! (key-code-name KeyEvent:VK_DEAD_CEDILLA) 'dead-cedilla)
  (set! (key-code-name KeyEvent:VK_DEAD_CIRCUMFLEX) 'dead-circumflex)
  (set! (key-code-name KeyEvent:VK_DEAD_DIAERESIS) 'dead-diaeresis)
  (set! (key-code-name KeyEvent:VK_DEAD_DOUBLEACUTE)
	'dead-double-acute)
  (set! (key-code-name KeyEvent:VK_DEAD_GRAVE) 'dead-grave)
  (set! (key-code-name KeyEvent:VK_DEAD_IOTA) 'dead-iota)
  (set! (key-code-name KeyEvent:VK_DEAD_MACRON) 'dead-macron)
  (set! (key-code-name KeyEvent:VK_DEAD_OGONEK) 'dead-ogonek)
  (set! (key-code-name KeyEvent:VK_DEAD_SEMIVOICED_SOUND)
	'dead-semivoiced-sound)
  (set! (key-code-name KeyEvent:VK_DEAD_TILDE) 'dead-tilde)
  (set! (key-code-name KeyEvent:VK_DEAD_VOICED_SOUND)
	'dead-voiced-sound)
  (set! (key-code-name KeyEvent:VK_DECIMAL) 'decimal)
  (set! (key-code-name KeyEvent:VK_DIVIDE) 'divide)
  (set! (key-code-name KeyEvent:VK_FIND) 'find)
  (set! (key-code-name KeyEvent:VK_FULL_WIDTH) 'full-width)
  (set! (key-code-name KeyEvent:VK_HALF_WIDTH) 'half-width)
  (set! (key-code-name KeyEvent:VK_HELP) 'help)
  (set! (key-code-name KeyEvent:VK_HIRAGANA) 'hiragana)
  (set! (key-code-name KeyEvent:VK_INPUT_METHOD_ON_OFF)
	'input-method-on/off)
  (set! (key-code-name KeyEvent:VK_INVERTED_EXCLAMATION_MARK)
	'inverted-exclamation-mark)
  (set! (key-code-name KeyEvent:VK_JAPANESE_HIRAGANA)
	'japanese-hiragana)
  (set! (key-code-name KeyEvent:VK_JAPANESE_KATAKANA)
	'japanese-katakana)
  (set! (key-code-name KeyEvent:VK_JAPANESE_ROMAN)
	'japanese-roman)
  (set! (key-code-name KeyEvent:VK_KANA) 'kana)
  (set! (key-code-name KeyEvent:VK_KANA_LOCK) 'kana-lock)
  (set! (key-code-name KeyEvent:VK_KANJI) 'kanji)
  (set! (key-code-name KeyEvent:VK_KATAKANA) 'katakana)
  (set! (key-code-name KeyEvent:VK_MULTIPLY) 'multiply)
  (set! (key-code-name KeyEvent:VK_MODECHANGE) 'mode-change)
  (set! (key-code-name KeyEvent:VK_NONCONVERT) 'non-convert)
  (set! (key-code-name KeyEvent:VK_PREVIOUS_CANDIDATE)
	'previous-candidate)
  (set! (key-code-name KeyEvent:VK_PROPS) 'props)
  (set! (key-code-name KeyEvent:VK_ROMAN_CHARACTERS)
	'roman-characters)
  
  (set! (key-code-name 0) 'unknown-key)
  (set! (key-code-name KeyEvent:VK_CONTROL) 'control)
  (set! (key-code-name KeyEvent:VK_CONTROL) 'ctrl)
  (set! (key-code-name KeyEvent:VK_META) 'meta)
  (set! (key-code-name KeyEvent:VK_SHIFT) 'shift)
  (set! (key-code-name KeyEvent:VK_WINDOWS) 'windows)
  (set! (key-code-name KeyEvent:VK_ALT) 'alt)
  
  (set! (key-code-name KeyEvent:VK_STOP) 'stop)
  (set! (key-code-name KeyEvent:VK_SUBTRACT) 'subtract)
  
  (set! (key-code-name KeyEvent:VK_AMPERSAND) 'ampersand)
  (set! (key-code-name KeyEvent:VK_AMPERSAND) #\&)
  (set! (key-code-name KeyEvent:VK_AMPERSAND) '&)

  (set! (key-code-name KeyEvent:VK_ASTERISK) 'asterisk)
  (set! (key-code-name KeyEvent:VK_ASTERISK) #\*)
  (set! (key-code-name KeyEvent:VK_ASTERISK) '*)
  
  (set! (key-code-name KeyEvent:VK_AT) #\@)
  (set! (key-code-name KeyEvent:VK_AT) 'at)
  
  (set! (key-code-name KeyEvent:VK_BACK_QUOTE) #\`)
  (set! (key-code-name KeyEvent:VK_BACK_QUOTE) 'backquote)

  (set! (key-code-name KeyEvent:VK_BACK_SLASH) '\\)
  (set! (key-code-name KeyEvent:VK_BACK_SLASH) #\\)
  (set! (key-code-name KeyEvent:VK_BACK_SLASH) 'backslash)

  (set! (key-code-name KeyEvent:VK_CAPS_LOCK) 'caps-lock)
  (set! (key-code-name KeyEvent:VK_CIRCUMFLEX) #\^)
  (set! (key-code-name KeyEvent:VK_CIRCUMFLEX) '^)
  (set! (key-code-name KeyEvent:VK_CLEAR) 'clear)
  (set! (key-code-name KeyEvent:VK_COLON) #\:)
  (set! (key-code-name KeyEvent:VK_COLON) ':)
  (set! (key-code-name KeyEvent:VK_COLON) 'colon)

  (set! (key-code-name KeyEvent:VK_COMMA) #\,)
  (set! (key-code-name KeyEvent:VK_COMMA) 'comma)
  (set! (key-code-name KeyEvent:VK_DOLLAR) 'dollar)
  (set! (key-code-name KeyEvent:VK_DOLLAR) #\$)
  (set! (key-code-name KeyEvent:VK_DOLLAR) '$)
  (set! (key-code-name KeyEvent:VK_EQUALS) 'equals)
  (set! (key-code-name KeyEvent:VK_EQUALS) #\=)
  (set! (key-code-name KeyEvent:VK_EQUALS) '=)
  (set! (key-code-name KeyEvent:VK_EURO_SIGN) 'euro)
  (set! (key-code-name KeyEvent:VK_EXCLAMATION_MARK)
	'exclamation-mark)
  (set! (key-code-name KeyEvent:VK_EXCLAMATION_MARK) #\!)
  (set! (key-code-name KeyEvent:VK_EXCLAMATION_MARK) '!)
  (set! (key-code-name KeyEvent:VK_GREATER) 'greater)
  (set! (key-code-name KeyEvent:VK_GREATER) #\>)  
  (set! (key-code-name KeyEvent:VK_GREATER) '>)
  (set! (key-code-name KeyEvent:VK_LESS) 'less)
  (set! (key-code-name KeyEvent:VK_LESS) #\<)
  (set! (key-code-name KeyEvent:VK_LESS) '<)
  (set! (key-code-name KeyEvent:VK_MINUS) 'minus)
  (set! (key-code-name KeyEvent:VK_MINUS) #\-)
  (set! (key-code-name KeyEvent:VK_MINUS) '-)
  (set! (key-code-name KeyEvent:VK_NUMBER_SIGN) 'hash)
  (set! (key-code-name KeyEvent:VK_NUMBER_SIGN) #\#)

  (set! (key-code-name KeyEvent:VK_PERIOD) 'period)
  (set! (key-code-name KeyEvent:VK_PERIOD) 'dot)
  (set! (key-code-name KeyEvent:VK_PERIOD) #\.)
  (set! (key-code-name KeyEvent:VK_PLUS) 'plus)
  (set! (key-code-name KeyEvent:VK_PLUS) #\+)
  (set! (key-code-name KeyEvent:VK_PLUS) '+)
  (set! (key-code-name KeyEvent:VK_QUOTE) 'quote)
  (set! (key-code-name KeyEvent:VK_QUOTE) #\')
  (set! (key-code-name KeyEvent:VK_QUOTEDBL) 'double-quote)
  (set! (key-code-name KeyEvent:VK_QUOTEDBL) #\")
  (set! (key-code-name KeyEvent:VK_SEMICOLON) 'semicolon)
  (set! (key-code-name KeyEvent:VK_SEMICOLON) #\;)
  (set! (key-code-name KeyEvent:VK_SLASH) 'slash)
  (set! (key-code-name KeyEvent:VK_SLASH) #\/)
  (set! (key-code-name KeyEvent:VK_SLASH) '/)
  (set! (key-code-name KeyEvent:VK_UNDERSCORE) 'underscore)
  (set! (key-code-name KeyEvent:VK_UNDERSCORE) #\_)
  (set! (key-code-name KeyEvent:VK_UNDERSCORE) '_)
  
  (set! (key-code-name KeyEvent:VK_NUMPAD0) 'num0)
  (set! (key-code-name KeyEvent:VK_NUMPAD1) 'num1)
  (set! (key-code-name KeyEvent:VK_NUMPAD2) 'num2)
  (set! (key-code-name KeyEvent:VK_NUMPAD3) 'num3)
  (set! (key-code-name KeyEvent:VK_NUMPAD4) 'num4)
  (set! (key-code-name KeyEvent:VK_NUMPAD5) 'num5)
  (set! (key-code-name KeyEvent:VK_NUMPAD6) 'num6)
  (set! (key-code-name KeyEvent:VK_NUMPAD7) 'num7)
  (set! (key-code-name KeyEvent:VK_NUMPAD8) 'num8)
  (set! (key-code-name KeyEvent:VK_NUMPAD9) 'num9)
  (set! (key-code-name KeyEvent:VK_SEPARATOR) 'numpad-separator)
  
  (set! (key-code-name KeyEvent:VK_F1) 'F1)
  (set! (key-code-name KeyEvent:VK_F2) 'F2)
  (set! (key-code-name KeyEvent:VK_F3) 'F3)
  (set! (key-code-name KeyEvent:VK_F4) 'F4)
  (set! (key-code-name KeyEvent:VK_F5) 'F5)
  (set! (key-code-name KeyEvent:VK_F6) 'F6)
  (set! (key-code-name KeyEvent:VK_F7) 'F7)
  (set! (key-code-name KeyEvent:VK_F8) 'F8)
  (set! (key-code-name KeyEvent:VK_F9) 'F9)
  (set! (key-code-name KeyEvent:VK_F10) 'F10)
  (set! (key-code-name KeyEvent:VK_F11) 'F11)
  (set! (key-code-name KeyEvent:VK_F12) 'F12)
  (set! (key-code-name KeyEvent:VK_F13) 'F13)
  (set! (key-code-name KeyEvent:VK_F14) 'F14)
  (set! (key-code-name KeyEvent:VK_F15) 'F15)
  (set! (key-code-name KeyEvent:VK_F16) 'F16)
  (set! (key-code-name KeyEvent:VK_F17) 'F17)
  (set! (key-code-name KeyEvent:VK_F18) 'F18)
  (set! (key-code-name KeyEvent:VK_F19) 'F19)
  (set! (key-code-name KeyEvent:VK_F20) 'F20)
  (set! (key-code-name KeyEvent:VK_F21) 'F21)
  (set! (key-code-name KeyEvent:VK_F22) 'F22)
  (set! (key-code-name KeyEvent:VK_F23) 'F23)
  (set! (key-code-name KeyEvent:VK_F24) 'F24)

  (set! (key-code-name KeyEvent:VK_0) #\0)
  (set! (key-code-name KeyEvent:VK_1) #\1)
  (set! (key-code-name KeyEvent:VK_2) #\2)
  (set! (key-code-name KeyEvent:VK_3) #\3)
  (set! (key-code-name KeyEvent:VK_4) #\4)
  (set! (key-code-name KeyEvent:VK_5) #\5)
  (set! (key-code-name KeyEvent:VK_6) #\6)
  (set! (key-code-name KeyEvent:VK_7) #\7)
  (set! (key-code-name KeyEvent:VK_8) #\8)
  (set! (key-code-name KeyEvent:VK_9) #\9)
  
  (set! (key-code-name KeyEvent:VK_0) 0)
  (set! (key-code-name KeyEvent:VK_1) 1)
  (set! (key-code-name KeyEvent:VK_2) 2)
  (set! (key-code-name KeyEvent:VK_3) 3)
  (set! (key-code-name KeyEvent:VK_4) 4)
  (set! (key-code-name KeyEvent:VK_5) 5)
  (set! (key-code-name KeyEvent:VK_6) 6)
  (set! (key-code-name KeyEvent:VK_7) 7)
  (set! (key-code-name KeyEvent:VK_8) 8)
  (set! (key-code-name KeyEvent:VK_9) 9)

  (set! (key-code-name KeyEvent:VK_A) #\a)
  (set! (key-code-name KeyEvent:VK_B) #\b)
  (set! (key-code-name KeyEvent:VK_C) #\c)
  (set! (key-code-name KeyEvent:VK_D) #\d)
  (set! (key-code-name KeyEvent:VK_E) #\e)
  (set! (key-code-name KeyEvent:VK_F) #\f)
  (set! (key-code-name KeyEvent:VK_G) #\g)
  (set! (key-code-name KeyEvent:VK_H) #\h)
  (set! (key-code-name KeyEvent:VK_I) #\i)
  (set! (key-code-name KeyEvent:VK_J) #\j)
  (set! (key-code-name KeyEvent:VK_K) #\k)
  (set! (key-code-name KeyEvent:VK_L) #\l)
  (set! (key-code-name KeyEvent:VK_M) #\m)
  (set! (key-code-name KeyEvent:VK_N) #\n)
  (set! (key-code-name KeyEvent:VK_O) #\o)
  (set! (key-code-name KeyEvent:VK_P) #\p)
  (set! (key-code-name KeyEvent:VK_Q) #\q)
  (set! (key-code-name KeyEvent:VK_R) #\r)
  (set! (key-code-name KeyEvent:VK_S) #\s)
  (set! (key-code-name KeyEvent:VK_T) #\t)
  (set! (key-code-name KeyEvent:VK_U) #\u)
  (set! (key-code-name KeyEvent:VK_V) #\v)
  (set! (key-code-name KeyEvent:VK_W) #\w)
  (set! (key-code-name KeyEvent:VK_X) #\x)
  (set! (key-code-name KeyEvent:VK_Y) #\y)
  (set! (key-code-name KeyEvent:VK_Z) #\z)
  
  (set! (key-code-name KeyEvent:VK_A) 'a)
  (set! (key-code-name KeyEvent:VK_B) 'b)
  (set! (key-code-name KeyEvent:VK_C) 'c)
  (set! (key-code-name KeyEvent:VK_D) 'd)
  (set! (key-code-name KeyEvent:VK_E) 'e)
  (set! (key-code-name KeyEvent:VK_F) 'f)
  (set! (key-code-name KeyEvent:VK_G) 'g)
  (set! (key-code-name KeyEvent:VK_H) 'h)
  (set! (key-code-name KeyEvent:VK_I) 'i)
  (set! (key-code-name KeyEvent:VK_J) 'j)
  (set! (key-code-name KeyEvent:VK_K) 'k)
  (set! (key-code-name KeyEvent:VK_L) 'l)
  (set! (key-code-name KeyEvent:VK_M) 'm)
  (set! (key-code-name KeyEvent:VK_N) 'n)
  (set! (key-code-name KeyEvent:VK_O) 'o)
  (set! (key-code-name KeyEvent:VK_P) 'p)
  (set! (key-code-name KeyEvent:VK_Q) 'q)
  (set! (key-code-name KeyEvent:VK_R) 'r)
  (set! (key-code-name KeyEvent:VK_S) 's)
  (set! (key-code-name KeyEvent:VK_T) 't)
  (set! (key-code-name KeyEvent:VK_U) 'u)
  (set! (key-code-name KeyEvent:VK_V) 'v)
  (set! (key-code-name KeyEvent:VK_W) 'w)
  (set! (key-code-name KeyEvent:VK_X) 'x)
  (set! (key-code-name KeyEvent:VK_Y) 'y)
  (set! (key-code-name KeyEvent:VK_Z) 'z)

  (set! (key-code-name KeyEvent:VK_LEFT) 'left)
  (set! (key-code-name KeyEvent:VK_RIGHT) 'right)
  (set! (key-code-name KeyEvent:VK_UP) 'up)
  (set! (key-code-name KeyEvent:VK_DOWN) 'down)

  (set! (key-code-name KeyEvent:VK_KP_LEFT) 'numpad-left)
  (set! (key-code-name KeyEvent:VK_KP_RIGHT) 'numpad-right)
  (set! (key-code-name KeyEvent:VK_KP_UP) 'numpad-up)
  (set! (key-code-name KeyEvent:VK_KP_DOWN) 'numpad-down)

  (set! (key-code-name KeyEvent:VK_SPACE) #\space)
  (set! (key-code-name KeyEvent:VK_SPACE) 'space)
  
  (set! (key-code-name KeyEvent:VK_BACK_SPACE) #\backspace)
  (set! (key-code-name KeyEvent:VK_BACK_SPACE) 'backspace)
  (set! (key-code-name KeyEvent:VK_DELETE) 'del)
  (set! (key-code-name KeyEvent:VK_DELETE) 'delete)

  (set! (key-code-name KeyEvent:VK_ENTER) #\return)
  (set! (key-code-name KeyEvent:VK_ENTER) 'enter)
  (set! (key-code-name KeyEvent:VK_ESCAPE) 'esc)
  (set! (key-code-name KeyEvent:VK_ESCAPE) 'escape)

  (set! (key-code-name KeyEvent:VK_HOME) 'home)
  (set! (key-code-name KeyEvent:VK_INSERT) 'ins)
  (set! (key-code-name KeyEvent:VK_INSERT) 'insert)
  
  (set! (key-code-name KeyEvent:VK_PAGE_UP) 'pgup)
  (set! (key-code-name KeyEvent:VK_PAGE_UP) 'page-up)
  (set! (key-code-name KeyEvent:VK_PAGE_DOWN) 'pgdn)
  (set! (key-code-name KeyEvent:VK_PAGE_DOWN) 'page-down)
    
  (set! (key-code-name KeyEvent:VK_PAUSE) 'pause)

  (set! (key-code-name KeyEvent:VK_PRINTSCREEN) 'print-screen)
  (set! (key-code-name KeyEvent:VK_SCROLL_LOCK) 'scroll-lock)
  (set! (key-code-name KeyEvent:VK_NUM_LOCK) 'num-lock)
  
  (set! (key-code-name KeyEvent:VK_TAB) #\t)
  (set! (key-code-name KeyEvent:VK_TAB) 'tab)
  
  (set! (key-code-name KeyEvent:VK_LEFT_PARENTHESIS)
	'opening-parenthesis)
  (set! (key-code-name KeyEvent:VK_LEFT_PARENTHESIS) 'opening-paren)
  (set! (key-code-name KeyEvent:VK_LEFT_PARENTHESIS) 'open-parenthesis)
  (set! (key-code-name KeyEvent:VK_LEFT_PARENTHESIS) 'open-paren)
  (set! (key-code-name KeyEvent:VK_LEFT_PARENTHESIS) 'left-parenthesis)
  (set! (key-code-name KeyEvent:VK_LEFT_PARENTHESIS) 'left-paren)
  (set! (key-code-name KeyEvent:VK_LEFT_PARENTHESIS) #\()
  
  (set! (key-code-name KeyEvent:VK_RIGHT_PARENTHESIS)
	'closing-parenthesis)
  (set! (key-code-name KeyEvent:VK_RIGHT_PARENTHESIS)
	'closing-paren)
  (set! (key-code-name KeyEvent:VK_RIGHT_PARENTHESIS)
	'close-parenthesis)
  (set! (key-code-name KeyEvent:VK_RIGHT_PARENTHESIS) 'close-paren)
  (set! (key-code-name KeyEvent:VK_RIGHT_PARENTHESIS)
	'right-parenthesis)
  (set! (key-code-name KeyEvent:VK_RIGHT_PARENTHESIS) 'right-paren)
  (set! (key-code-name KeyEvent:VK_RIGHT_PARENTHESIS) #\))
  
  (set! (key-code-name KeyEvent:VK_OPEN_BRACKET) 'opening-bracket)
  (set! (key-code-name KeyEvent:VK_OPEN_BRACKET) 'open-bracket)
  (set! (key-code-name KeyEvent:VK_OPEN_BRACKET) 'left-bracket)
  (set! (key-code-name KeyEvent:VK_OPEN_BRACKET) #\[)
  
  (set! (key-code-name KeyEvent:VK_CLOSE_BRACKET) 'closing-bracket)
  (set! (key-code-name KeyEvent:VK_CLOSE_BRACKET) 'close-bracket)
  (set! (key-code-name KeyEvent:VK_CLOSE_BRACKET) 'right-bracket)
  (set! (key-code-name KeyEvent:VK_CLOSE_BRACKET) #\])
  
  (set! (key-code-name KeyEvent:VK_BRACELEFT) 'opening-brace)
  (set! (key-code-name KeyEvent:VK_BRACELEFT) 'open-brace)
  (set! (key-code-name KeyEvent:VK_BRACELEFT) 'left-brace)
  (set! (key-code-name KeyEvent:VK_BRACELEFT) #\{)
  
  (set! (key-code-name KeyEvent:VK_BRACERIGHT) 'closing-brace)
  (set! (key-code-name KeyEvent:VK_BRACERIGHT) 'close-brace)
  (set! (key-code-name KeyEvent:VK_BRACERIGHT) 'right-brace)
  (set! (key-code-name KeyEvent:VK_BRACERIGHT) #\})
  
  )
