#lang setup/infotab

(define drracket-tools '(("tool.rkt")))

(define drracket-tool-names (list "KeyLogging"))
(define drracket-tool-icons '(#f))
(define primary-file "tool.rkt")

(define deps '("base" "gui-lib" "data-lib" "drracket-plugin-lib"))
(define single-collection "key-logging")

(define verion "0.1")