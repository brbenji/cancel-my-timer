/+  verb, dbug, default-agent
::
|%
+$  versioned-state  $%(state-0)
+$  state-0  [%0 date=@da ~]
+$  action
  $%  [%set-our date=@da]
      [%cancel-our ~]
      [%set-her her=ship date=@da]
      [%cancel-her her=ship]
      [%set date=@da]
      [%cancel ~]
  ==
+$  card  card:agent:gall
--
::
%+  verb  |
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
::
|_  =bowl:gall
+*  this  .
    def  ~(. (default-agent this %|) bowl)
::
++  on-init  on-init:def
++  on-save  on-save:def
++  on-load  on-load:def
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  =/  act  !<(action vase)
  ?-    -.act
    ::
    :: handle our timers
    ::
      %set-our
    ?<  =(date.act ~)
    =/  dat  date.act
    :_  this(date dat)
    ~[[%pass /always/the/same/wire %arvo %b %wait dat]]
    ::
      %cancel-our
    :_  this
    ~[[%pass /always/the/same/wire %arvo %b %rest date]]
    ::
    ::  send her a poke
    ::
      %set-her
    =/  =action  [%set date.act]
    :_  this
    [[%pass /wait/poke %agent [her.act dap.bowl] %poke %action !>(action)]]~
    ::
      %cancel-her
    =/  =action  [%cancel ~]
    :_  this
    [[%pass /rest/poke %agent [her.act dap.bowl] %poke %action !>(action)]]~
    ::
    ::  as her handle timers
    ::
      %set
    ~&  "request to set timer from {<src.bowl>}"
    ?<  =(src.bowl our.bowl)
    =/  dat  date.act
    :_  this(date dat)
    ~[[%pass /always/the/same/wire %arvo %b %wait dat]]
    ::
      %cancel
    ~&  "request to cancel from {<src.bowl>}"
    ?<  =(src.bowl our.bowl)
    :_  this
    ~[[%pass /always/the/same/wire %arvo %b %rest date]]
  ==
::
++  on-peek  on-peek:def
++  on-agent
  |=  [wir=wire sig=sign:agent:gall]
  ^-  (quip card _this)
  ~&  >  "asking {<src.bowl>} to {<&1:wir>}."
  `this
::
++  on-arvo
  |=  [wir=wire sig=sign-arvo]
  ^-  (quip card _this)
  ?+    wir  (on-arvo:def wir sig)
      [%always %the %same %wire ~]
    ?>  ?=([%behn %wake *] sig)
    ~&  "wake-up!"
  `this
  ==
::
++  on-watch  on-watch:def
++  on-fail   on-fail:def
++  on-leave  on-leave:def
--
