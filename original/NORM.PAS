program NormalVideo;

Uses MSGraph , Crt;

Var video : integer;

BEGIN

  _SetTextCursor($2000);
  video := _SetVideoMode(_TextC80);
  _SetTextCursor($0707);

END.
