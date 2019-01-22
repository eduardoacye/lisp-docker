(ql:quickload :swank)
(setf swank:*globally-redirect-io* t)
(setf swank::*loopback-interface* "0.0.0.0")
(swank:create-server :dont-close t)
