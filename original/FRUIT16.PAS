PROGRAM SlotMachineSimulator(input,output);
{ Computing III , Major Assignment .
  Tutor : Ken Lodge .

  This program simulates a slot machine using a graphical display
  and scrolling pictures .  }

USES
  MSGraph,
  Crt;

CONST         (* These are keys used by the simulator         *)
  crlf      = #13 + #10;   (* Carriage Return & Line Feed Key *)
  lf        = #10;         (* Line Feed Key                   *)
  UpArrow   = #72;  DownArrow  = #80;
  LeftArrow = #75;  RightArrow = #77;
  PgUp      = #73;  PgDn       = #81;
  HomeKey   = #71;  EndKey     = #79;
  Ins       = #82;  Del        = #83;
  ENTER     = #13;  ESC        = #27;
  BS        = #8 ;  CtrBS      = #127;
  Menu1Set  = ['1'..'8'];         (* Menu1 Option Keys      *)
  Menu6Set  = ['y','Y','n','N'];  (* Response Keys          *)
  NumberSet = ['0'..'9'] ;        (* Valid Numbers to Enter *)
  BetSet    = ['1'..'5'] ;        (* Valid Bets to Enter    *)

TYPE
  ImageType = ^Byte;  (* Storage of graphical images        *)
  SplitType = record  (* Split Storage of graphical images  *)
		Line : array[1..31] of ImageType; (* Split image      *)
		LineSize : array[1..31] of Word;  (* Split image size *)
	      end;
  String10 = String[10];

VAR
  Scrolling , Fast(*Scrolling*) , Snd(*Sound*): boolean;
  Name (*Users'*) ,
  StNum(* Used for converting nums to strings   *) : CString;
  buffer  : char;      (* key the user presses  *)
  NumSims ,            (* Number of Simulations *)
  CurSim  ,            (* Current Simulation Number *)
  Credit  ,
  NumOfBets ,          (* Number Of Bets in a Simulation *)
  BetNum  ,            (* Current Bet Number             *)
  video   ,            (* Contains the Video Mode        *)
  x , y , i ,
  count     : integer;
  oldcolor  : Longint; (* Used for changing the pallette *)
  (* Stored Images *)
  CherryImage , BarImage , PlumImage , OrangeImage , BellImage ,
  DisplayBox1  : ImageType;
  (* Stored Image Sizes *)
  CherrySize , BarSize , PlumSize , OrangeSize , BellSize ,
  DisplaySize1 : Word;
  (* Stored Split Images *)
  SplitCherry , SplitBar , SplitPlum , SplitOrange ,
  SplitBell    : SplitType;

Procedure DrawBell(x,y:integer);
(* This procedure takes x and y viewport co-ordinates
   and draws a bell as a series of vertical lines each
   with a different colour . The extent of the graphic
   is a 30 X 30 square with the top left corner at (x,y) *)

Var
  color : integer;

Begin (* DrawBell *)

  color := 105 ;
  _SetColor(color +  4);  _MoveTo(x +  4,y + 22);  _LineTo(x +  4,y + 25);
  _SetColor(color +  5);  _MoveTo(x +  5,y + 21);  _LineTo(x +  5,y + 25);
  _SetColor(color +  6);  _MoveTo(x +  6,y + 18);  _LineTo(x +  6,y + 25);
  _SetColor(color +  7);  _MoveTo(x +  7,y + 13);  _LineTo(x +  7,y + 25);
  _SetColor(color +  8);  _MoveTo(x +  8,y + 10);  _LineTo(x +  8,y + 25);
  _SetColor(color +  9);  _MoveTo(x +  9,y +  8);  _LineTo(x +  9,y + 25);
  _SetColor(color + 10);  _MoveTo(x + 10,y +  7);  _LineTo(x + 10,y + 25);
  _SetColor(color + 11);  _MoveTo(x + 11,y +  7);  _LineTo(x + 11,y + 25);
  _SetColor(color + 12);  _MoveTo(x + 12,y +  6);  _LineTo(x + 12,y + 25);
  _SetColor(color + 13);  _MoveTo(x + 13,y +  6);  _LineTo(x + 13,y + 26);
  _SetPixel(x + 13,y + 4);
  _SetColor(color + 14);  _MoveTo(x + 14,y +  3);  _LineTo(x + 14,y + 27);
  _SetColor(color + 15);  _MoveTo(x + 15,y +  2);  _LineTo(x + 15,y + 28);
  _SetColor(color + 16);  _MoveTo(x + 16,y +  2);  _LineTo(x + 16,y + 28);
  _SetColor(color + 17);  _MoveTo(x + 17,y +  3);  _LineTo(x + 17,y + 27);
  _SetColor(color + 18);  _MoveTo(x + 18,y +  6);  _LineTo(x + 18,y + 26);
  _SetPixel(x + 18,y + 4);
  _SetColor(color + 19);  _MoveTo(x + 19,y +  6);  _LineTo(x + 19,y + 25);
  _SetColor(color + 20);  _MoveTo(x + 20,y +  7);  _LineTo(x + 20,y + 25);
  _SetColor(color + 21);  _MoveTo(x + 21,y +  7);  _LineTo(x + 21,y + 25);
  _SetColor(color + 22);  _MoveTo(x + 22,y +  8);  _LineTo(x + 22,y + 25);
  _SetColor(color + 23);  _MoveTo(x + 23,y + 10);  _LineTo(x + 23,y + 25);
  _SetColor(color + 24);  _MoveTo(x + 24,y + 13);  _LineTo(x + 24,y + 25);
  _SetColor(color + 25);  _MoveTo(x + 25,y + 18);  _LineTo(x + 25,y + 25);
  _SetColor(color + 26);  _MoveTo(x + 26,y + 21);  _LineTo(x + 26,y + 25);
  _SetColor(color + 27);  _MoveTo(x + 27,y + 22);  _LineTo(x + 27,y + 25);

End;  (* DrawBell *)

Procedure DrawOrange(x,y:integer);
(* This procedure takes x and y viewport co-ordinates
   and draws an orange as a series of vertical lines each
   with a different colour . The extent of the graphic
   is a 30 X 30 square with the top left corner at (x,y) *)

Var
  color : integer;

Begin (* DrawOrange *)

  color := 135 ;
  _SetColor(color +  4);  _MoveTo(x +  4,y + 13);  _LineTo(x +  4,y + 18);
  _SetColor(color +  5);  _MoveTo(x +  5,y + 11);  _LineTo(x +  5,y + 20);
  _SetColor(color +  6);  _MoveTo(x +  6,y +  9);  _LineTo(x +  6,y + 22);
  _SetColor(color +  7);  _MoveTo(x +  7,y +  8);  _LineTo(x +  7,y + 23);
  _SetColor(color +  8);  _MoveTo(x +  8,y +  7);  _LineTo(x +  8,y + 24);
  _SetColor(color +  9);  _MoveTo(x +  9,y +  6);  _LineTo(x +  9,y + 25);
  _SetColor(color + 10);  _MoveTo(x + 10,y +  6);  _LineTo(x + 10,y + 25);
  _SetColor(color + 11);  _MoveTo(x + 11,y +  5);  _LineTo(x + 11,y + 26);
  _SetColor(color + 12);  _MoveTo(x + 12,y +  5);  _LineTo(x + 12,y + 26);
  _SetColor(color + 13);  _MoveTo(x + 13,y +  4);  _LineTo(x + 13,y + 27);
  _SetColor(color + 14);  _MoveTo(x + 14,y +  4);  _LineTo(x + 14,y + 27);
  _SetColor(color + 15);  _MoveTo(x + 15,y +  4);  _LineTo(x + 15,y + 27);
  _SetColor(color + 16);  _MoveTo(x + 16,y +  4);  _LineTo(x + 16,y + 27);
  _SetColor(color + 17);  _MoveTo(x + 17,y +  4);  _LineTo(x + 17,y + 27);
  _SetColor(color + 18);  _MoveTo(x + 18,y +  4);  _LineTo(x + 18,y + 27);
  _SetColor(color + 19);  _MoveTo(x + 19,y +  5);  _LineTo(x + 19,y + 26);
  _SetColor(color + 20);  _MoveTo(x + 20,y +  5);  _LineTo(x + 20,y + 26);
  _SetColor(color + 21);  _MoveTo(x + 21,y +  6);  _LineTo(x + 21,y + 25);
  _SetColor(color + 22);  _MoveTo(x + 22,y +  6);  _LineTo(x + 22,y + 25);
  _SetColor(color + 23);  _MoveTo(x + 23,y +  7);  _LineTo(x + 23,y + 24);
  _SetColor(color + 24);  _MoveTo(x + 24,y +  8);  _LineTo(x + 24,y + 23);
  _SetColor(color + 25);  _MoveTo(x + 25,y +  9);  _LineTo(x + 25,y + 22);
  _SetColor(color + 26);  _MoveTo(x + 26,y + 11);  _LineTo(x + 26,y + 20);
  _SetColor(color + 27);  _MoveTo(x + 27,y + 13);  _LineTo(x + 27,y + 18);
  _SetColor(color +  4);
  _Arc(x + 7,y + 7,x + 25,y + 25,x + 24,y + 13,x + 18,y +7);

End;  (* DrawOrange *)

Procedure DrawPlum(x,y:integer);
(* This procedure takes x and y viewport co-ordinates
   and draws a plum as a series of vertical lines each
   with a different colour . The extent of the graphic
   is a 30 X 30 square with the top left corner at (x,y) *)

Var
  color : integer;

Begin (* DrawPlum *)

  color := 165 ;
  color := color + 5;
  _SetColor(color +  5); (* 175 - 195 *)
  _MoveTo(x +  5,y + 17);  _LineTo(x +  5,y + 20);
   (* Dark Line *)
  _MoveTo(x + 13,y + 13);  _LineTo(x + 13,y + 16);
  _MoveTo(x + 14,y + 11);  _LineTo(x + 14,y + 12);
  _MoveTo(x + 15,y +  9);  _LineTo(x + 15,y + 10);
  _SetColor(color +  6);  _MoveTo(x +  6,y + 14);  _LineTo(x +  6,y + 22);
  _SetColor(color +  7);  _MoveTo(x +  7,y + 12);  _LineTo(x +  7,y + 23);
  _SetColor(color +  8);  _MoveTo(x +  8,y + 11);  _LineTo(x +  8,y + 24);
  _SetColor(color +  9);  _MoveTo(x +  9,y + 10);  _LineTo(x +  9,y + 25);
  _SetColor(color + 10);  _MoveTo(x + 10,y + 10);  _LineTo(x + 10,y + 25);
  _SetColor(color + 11);  _MoveTo(x + 11,y +  9);  _LineTo(x + 11,y + 26);
  _SetColor(color + 12);  _MoveTo(x + 12,y +  9);  _LineTo(x + 12,y + 26);
  _SetColor(color + 13);  _MoveTo(x + 13,y +  8);  _LineTo(x + 13,y + 12);
  _MoveTo(x + 13,y + 17);  _LineTo(x + 13,y + 27);
  _SetColor(color + 14);  _MoveTo(x + 14,y +  8);  _LineTo(x + 14,y + 10);
  _MoveTo(x + 14,y + 13);  _LineTo(x + 14,y + 27);
  _SetColor(color + 15);  _MoveTo(x + 15,y + 11);  _LineTo(x + 15,y + 26);
  _SetColor(color + 16);  _MoveTo(x + 16,y +  9);  _LineTo(x + 16,y + 27);
  _SetColor(color + 17);  _MoveTo(x + 17,y +  8);  _LineTo(x + 17,y + 27);
  _SetColor(color + 18);  _MoveTo(x + 18,y +  8);  _LineTo(x + 18,y + 27);
  _SetColor(color + 19);  _MoveTo(x + 19,y +  8);  _LineTo(x + 19,y + 26);
  _SetColor(color + 20);  _MoveTo(x + 20,y +  8);  _LineTo(x + 20,y + 26);
  _SetColor(color + 21);  _MoveTo(x + 21,y +  9);  _LineTo(x + 21,y + 25);
  _SetColor(color + 22);  _MoveTo(x + 22,y +  9);  _LineTo(x + 22,y + 25);
  _SetColor(color + 23);  _MoveTo(x + 23,y + 10);  _LineTo(x + 23,y + 24);
  _SetColor(color + 24);  _MoveTo(x + 24,y + 11);  _LineTo(x + 24,y + 22);
  _SetColor(color + 25);  _MoveTo(x + 25,y + 13);  _LineTo(x + 25,y + 19);
  (* Stem *)
  color := color - 5 - 9; (* 166 - 172 *)
  _SetColor(color + 10);  _MoveTo(x + 10,y +  4);  _LineTo(x + 10,y +  5);
  _SetColor(color + 11);  _MoveTo(x + 11,y +  4);  _LineTo(x + 11,y +  5);
  _SetColor(color + 12);  _MoveTo(x + 12,y +  3);  _LineTo(x + 12,y +  4);
  _SetColor(color + 13);  _MoveTo(x + 13,y +  3);  _LineTo(x + 13,y +  3);
  _SetColor(color + 14);  _MoveTo(x + 14,y +  3);  _LineTo(x + 14,y +  4);
  _SetColor(color + 15);  _MoveTo(x + 15,y +  4);  _LineTo(x + 15,y +  5);
  _SetColor(color + 16);  _MoveTo(x + 16,y +  5);  _LineTo(x + 16,y +  7);

End;  (* DrawPlum *)

Procedure DrawBar(x,y:integer);
(* This procedure takes x and y viewport co-ordinates
   and draws a bar as a series of vertical lines each
   with a different colour . The extent of the graphic
   is a 30 X 30 square with the top left corner at (x,y) *)

Var
  color : integer;

Begin (* DrawBar *)

  color := 195 ;
  _SetColor(color +  1);
  _Rectangle(_GFillInterior,x+1,y+1,x+30,y+30);
  _SetColor(color +  2); (* 197 - 220 *)
  _MoveTo(x +  2,y +  8);  _LineTo(x +  2,y + 23);
  _SetColor(color +  3);  _MoveTo(x +  3,y +  8);  _LineTo(x +  3,y + 23);
  _SetColor(color +  4);  _MoveTo(x +  4,y +  8);  _LineTo(x +  4,y +  9);
  _MoveTo(x +  4,y + 15);  _LineTo(x +  4,y + 16);
  _MoveTo(x +  4,y + 22);  _LineTo(x +  4,y + 23);
  _SetColor(color +  5);  _MoveTo(x +  5,y +  8);  _LineTo(x +  5,y +  9);
  _MoveTo(x +  5,y + 15);  _LineTo(x +  5,y + 16);
  _MoveTo(x +  5,y + 22);  _LineTo(x +  5,y + 23);
  _SetColor(color +  6);  _MoveTo(x +  6,y +  8);  _LineTo(x +  6,y + 10);
  _MoveTo(x +  6,y + 14);  _LineTo(x +  6,y + 17);
  _MoveTo(x +  6,y + 21);  _LineTo(x +  6,y + 23);
  _SetColor(color +  7);  _MoveTo(x +  7,y +  9);  _LineTo(x +  7,y + 11);
  _MoveTo(x +  7,y + 13);  _LineTo(x +  7,y + 18);
  _MoveTo(x +  7,y + 20);  _LineTo(x +  7,y + 22);
  _SetColor(color +  8);  _MoveTo(x +  8,y + 10);  _LineTo(x +  8,y + 14);
  _MoveTo(x +  8,y + 17);  _LineTo(x +  8,y + 22);
  _SetColor(color +  9);  _MoveTo(x +  9,y + 11);  _LineTo(x +  9,y + 13);
  _MoveTo(x +  9,y + 18);  _LineTo(x +  9,y + 20);
  color := color - 2;
  _SetColor(color + 12);  _MoveTo(x + 12,y + 18);  _LineTo(x + 12,y + 23);
  _SetColor(color + 13);  _MoveTo(x + 13,y + 13);  _LineTo(x + 13,y + 23);
  _SetColor(color + 14);  _MoveTo(x + 14,y + 10);  _LineTo(x + 14,y + 20);
  _SetColor(color + 15);  _MoveTo(x + 15,y +  8);  _LineTo(x + 15,y + 14);
  _MoveTo(x + 15,y + 18);  _LineTo(x + 15,y + 19);
  _SetColor(color + 16);  _MoveTo(x + 16,y +  8);  _LineTo(x + 16,y + 14);
  _MoveTo(x + 16,y + 18);  _LineTo(x + 16,y + 19);
  _SetColor(color + 17);  _MoveTo(x + 17,y + 10);  _LineTo(x + 17,y + 20);
  _SetColor(color + 18);  _MoveTo(x + 18,y + 13);  _LineTo(x + 18,y + 23);
  _SetColor(color + 19);  _MoveTo(x + 19,y + 18);  _LineTo(x + 19,y + 23);
  color := color - 2;
  _SetColor(color + 22);  _MoveTo(x + 22,y +  8);  _LineTo(x + 22,y + 23);
  _SetColor(color + 23);  _MoveTo(x + 23,y +  8);  _LineTo(x + 23,y + 23);
  _SetColor(color + 24);  _MoveTo(x + 24,y +  8);  _LineTo(x + 24,y +  9);
  _MoveTo(x + 24,y + 15); _LineTo(x + 24,y + 16);
  _SetColor(color + 25);  _MoveTo(x + 25,y +  8);  _LineTo(x + 25,y +  9);
  _MoveTo(x + 25,y + 15);  _LineTo(x + 25,y + 17);
  _SetColor(color + 26);  _MoveTo(x + 26,y +  8);  _LineTo(x + 26,y + 10);
  _MoveTo(x + 26,y + 14);  _LineTo(x + 26,y + 19);
  _SetColor(color + 27);  _MoveTo(x + 27,y +  9);  _LineTo(x + 27,y + 11);
  _MoveTo(x + 27,y + 13);  _LineTo(x + 27,y + 15);
  _MoveTo(x + 27,y + 17);  _LineTo(x + 27,y + 21);
  _SetColor(color + 28);  _MoveTo(x + 28,y + 10);  _LineTo(x + 28,y + 14);
  _MoveTo(x + 28,y + 19);  _LineTo(x + 28,y + 23);
  _SetColor(color + 29);  _MoveTo(x + 29,y + 11);  _LineTo(x + 29,y + 13);
  _MoveTo(x + 29,y + 21);  _LineTo(x + 29,y + 23);

End;  (* DrawBar *)

Procedure DrawCherry(x,y:integer);
(* This procedure takes x and y viewport co-ordinates
   and draws a cherry as a series of vertical lines each
   with a different colour . The extent of the graphic
   is a 30 X 30 square with the top left corner at (x,y) *)

Var
  color : integer;

Begin (* DrawCherry *)

  color := 225 ;
  _SetColor(color +  4); (* 229 - 237 *)
  _MoveTo(x +  4,y + 21);  _LineTo(x +  4,y + 25);
  _MoveTo(x + 19,y + 21);  _LineTo(x + 19,y + 25);
  _SetColor(color +  5);  _MoveTo(x +  5,y + 20);  _LineTo(x +  5,y + 26);
  _MoveTo(x + 20,y + 20);  _LineTo(x + 20,y + 26);
  _SetColor(color +  6);  _MoveTo(x +  6,y + 19);  _LineTo(x +  6,y + 27);
  _MoveTo(x + 21,y + 19);  _LineTo(x + 21,y + 27);
  _SetColor(color +  7);  _MoveTo(x +  7,y + 19);  _LineTo(x +  7,y + 27);
  _MoveTo(x + 22,y + 22);  _LineTo(x + 22,y + 27);
  _SetColor(color +  8);  _MoveTo(x +  8,y + 19);  _LineTo(x +  8,y + 27);
  _MoveTo(x + 23,y + 22);  _LineTo(x + 23,y + 27);
  _SetColor(color +  9);  _MoveTo(x +  9,y + 19);  _LineTo(x +  9,y + 20);
  _MoveTo(x +  9,y + 23);  _LineTo(x +  9,y + 27);
  _MoveTo(x + 24,y + 19);  _LineTo(x + 24,y + 27);
  _SetColor(color + 10);  _MoveTo(x + 10,y + 19);  _LineTo(x + 10,y + 19);
  _MoveTo(x + 10,y + 23);  _LineTo(x + 10,y + 27);
  _MoveTo(x + 25,y + 19);  _LineTo(x + 25,y + 27);
  _SetColor(color + 11);  _MoveTo(x + 11,y + 22);  _LineTo(x + 11,y + 26);
  _MoveTo(x + 26,y + 20);  _LineTo(x + 26,y + 26);
  _SetColor(color + 12);  _MoveTo(x + 12,y + 21);  _LineTo(x + 12,y + 25);
  _MoveTo(x + 27,y + 21);  _LineTo(x + 27,y + 25);
  (* Stem *)
  color := color + 4; (* 238 - 252 *)
  _SetColor(color +  9);  _MoveTo(x +  9,y + 21);  _LineTo(x +  9,y + 22);
  _SetColor(color + 10);  _MoveTo(x + 10,y + 20);  _LineTo(x + 10,y + 22);
  _SetColor(color + 11);  _MoveTo(x + 11,y + 18);  _LineTo(x + 11,y + 21);
  _SetColor(color + 12);  _MoveTo(x + 12,y + 17);  _LineTo(x + 12,y + 19);
  _SetColor(color + 13);  _MoveTo(x + 13,y + 15);  _LineTo(x + 13,y + 18);
  _SetColor(color + 14);  _MoveTo(x + 14,y + 13);  _LineTo(x + 14,y + 16);
  _SetColor(color + 15);  _MoveTo(x + 15,y + 11);  _LineTo(x + 15,y + 14);
  _SetColor(color + 16);  _MoveTo(x + 16,y +  8);  _LineTo(x + 16,y + 12);
  _SetColor(color + 17);  _MoveTo(x + 17,y +  7);  _LineTo(x + 17,y + 10);
  _SetColor(color + 18);  _MoveTo(x + 18,y +  6);  _LineTo(x + 18,y +  8);
  _SetColor(color + 19);  _MoveTo(x + 19,y +  6);  _LineTo(x + 19,y +  7);
  _SetColor(color + 20);  _MoveTo(x + 20,y +  5);  _LineTo(x + 20,y + 11);
  _SetColor(color + 21);  _MoveTo(x + 21,y +  4);  _LineTo(x + 21,y + 16);
  _SetColor(color + 22);  _MoveTo(x + 22,y + 12);  _LineTo(x + 22,y + 21);
  _SetColor(color + 23);  _MoveTo(x + 23,y + 17);  _LineTo(x + 23,y + 21);

End;  (* DrawCherry *)

Procedure GetImage(x , y : integer;
		      var Image : ImageType;
		      var Split : SplitType;
		      var Size  : Word );
(* This procedure gets a 30 X 30 image using (x,y) as the top left
   corner and stores it in Image , it also breaks up the image into
   horizontal lines and stores them in Split . Size returns the size
   of the 30 X 30 image , Used to free memory later. *)

Var i : integer;

Begin (* Get Image *)

  For i := y to (y+30) do
    begin
      Split.LineSize[i-y+1] := _ImageSize(x,i,x+30,i);
      GetMem(Split.Line[i-y+1],Split.LineSize[i-y+1]);
      _GetImage(x,i,x+30,i,Split.Line[i-y+1]^);
    end;

  Size := _ImageSize(x+1,y+1,x+30,y+30);
  GetMem(Image , Size);
  _GetImage(x+1,y+1,x+30,y+30,Image^);

End;  (* GetImage *)

Procedure ChangeColors(arg : String10);
(* This procedure changes the VGA 256 Color palette.
   If arg = 'initialize' then colours 100 - 255 are
   changed to black.
   If arg = 'RemapColor' then the colours used in the
   program are changed eg the bell colours (100-130)
   are changed to shades of blue *)

Var
  oldcolor , newcolor , color : LongInt;
  i , row , col : integer;

Begin (* Change Colors *)

  col := 34;
  row := 1;
  if (arg = 'Initialize')
  then
    For i := 100 to 255 do
      begin
	if (i MOD 40 = 0)
	then
	  begin
	    _SetTextPosition(row,col);
	    _OutText(chr( ord('6')-(i DIV 40) ));
	  end; (* if *)
	if (i <> 15) (* Loading instruction *)
	then
	  oldcolor := _RemapPalette(i,$000000);
      end; (* For *)
  if (arg = 'RemapColor')
  then
    begin
      For i := 1 to 9 do (* Text Colors *)
	oldcolor := _RemapPalette(i,$3f3f3f);
      oldcolor := _RemapPalette(30,$10323f);
      oldcolor := _RemapPalette(31,$3f3014);
      oldcolor := _RemapPalette(32,$371e00);
      oldcolor := _RemapPalette(33,$002f3f);
      oldcolor := _RemapPalette(34,$103014);

      (* Bell *)
      color := 105 ; (* 109 - 132 *)
      newcolor := $3f0000 ;
      for i := (color + 4) to (color + 27) do
	begin
	  newcolor := newcolor + $000200;
	  oldcolor := _RemapPalette(i,newcolor);
	end;
      _SetTextPosition(row,col);
      _OutText('5');
      (* Orange *)
      color := 135 ;   (* 139 - 162 *)
      newcolor := $00143f ;
      for i := (color + 4) to (color + 27) do
	begin
	  newcolor := newcolor + $000100;
	  oldcolor := _RemapPalette(i,newcolor);
	end;
      (* PLUM *)
      (* Stem *)
      _SetTextPosition(row,col);
      _OutText('4');
      color := 165 ;
      color := color + 5;  (* 175 - 195 *)
      newcolor := $320032 ;
      for i := (color + 5) to (color + 25) do
	begin
	  oldcolor := _RemapPalette(i,newcolor);
	  newcolor := newcolor + $000200;
	end;
      _SetTextPosition(row,col);
      _OutText('3');
      color := color - 5 - 9; (* 166 - 172 *)
      newcolor := $001527 ;
      for i := (color + 10) to (color + 16) do
	begin
	  newcolor := newcolor + $000001;
	  oldcolor := _RemapPalette(i,newcolor);
	end;
      (* Bar *)
      color := 195 ;      (* 196 - 220 *)
      oldcolor := _RemapPalette(color + 1,$3f3f3f); (* White *)
      newcolor := $3f0000;
      _SetTextPosition(row,col);
      _OutText('2');
      for i := (color + 2) to (color + 25) do
	begin
	  newcolor := newcolor + $000202;
	  oldcolor := _RemapPalette(i,newcolor);
	end;
      (* cherry *)
      color := 225 ;      (* 229 - 237 *)
      newcolor := $00003f;
      for i := (color + 4) to (color + 12) do
	begin
	  oldcolor := _RemapPalette(i,newcolor);
	  newcolor := newcolor + $050500;
	end;
      _SetTextPosition(row,col);
      _OutText('1');
      (* Stem Cherry *)
      color := color + 4; (* 238 - 252 *)
      newcolor := $0f3f0f;
      for i := (color + 9) to (color + 23) do
	begin
	  oldcolor := _RemapPalette(i,newcolor);
	  newcolor := newcolor + $010002;
	end;
      _SetTextPosition(row,col);
      _OutText('0');
    end; (* if *)

End;  (* Change Colors *)

Procedure LoadGraphics(var BarImage,CherryImage,PlumImage,
			   OrangeImage,BellImage : ImageType;
		       var BarSize,CherrySize,PlumSize,
			   OrangeSize,BellSize   : Word;
		       var SplitBar,SplitCherry,SplitPlum,
			   SplitOrange,SplitBell : SplitType);
(* This procedure Loads the slot machine graphics into memory
   and changes the palette to appropriate colours *)

Begin (* LoadGraphics *)

  _OutText('Loading Graphics , Please wait - 4');
  _SetTextPosition(3,1);
  _OutText('COMPUTING III');
  _SetTextPosition(5,1);
  _OutText('Major Assignment');
  ChangeColors('Initialize');
  DrawBar(0,50);
  GetImage(0,50,BarImage,SplitBar,BarSize);
  DrawCherry(50,50);
  GetImage(50,50,CherryImage,SplitCherry,CherrySize);
  DrawPlum(0,100);
  GetImage(0,100,PlumImage,SplitPlum,PlumSize);
  DrawOrange(50,100);
  GetImage(50,100,OrangeImage,SplitOrange,OrangeSize);
  DrawBell(100,100);
  GetImage(100,100,BellImage,SplitBell,BellSize);
  _ClearScreen(_GViewPort);
  _SetTextPosition(1,1);
  _OutText('Loading Colours  , Please wait - 6');
  _SetTextPosition(7,8);
  _OutText('SLOT MACHINE SIMULATOR');
  _SetTextPosition(9,8);
  _OutText('~~~~~~~~~~~~~~~~~~~~~~');
  _SetTextPosition(11,8);
  _OutText('Tutor      : Ken Lodge');
  _SetTextPosition(13,8);
  _OutText('Programmer : Jeremy Larter');
  ChangeColors('RemapColor');
  _ClearScreen(_GViewPort);

End;  (* LoadGraphics *)

Procedure Box(Row , Col , MaxLen : integer);
{ Draw's a text box around a MaxLen text space
  starting at Row , Col. Leave's next _OutText
  to be drawn at Row , Col. }

Begin (* Box *)

  _SetTextColor(32);
  _SetTextPosition(Row-1,Col-1);
  _OutText('É');
  for i := 1 to MaxLen do
    _OutText('Í');
  _OutText('»');
  _SetTextPosition(Row,Col-1);
  _OutText('º');
  _SetTextPosition(Row,Col+MaxLen);
  _OutText('º');
  _SetTextPosition(Row+1,Col-1);
  _OutText('È');
  for i := 1 to MaxLen do
    _OutText('Í');
  _OutText('¼');
  _SetTextPosition(Row,Col);
  _SetTextColor(33);
  for i := 1 to MaxLen do
    _OutText('.');
  _SetTextColor(32);
  _SetTextPosition(Row,Col);

End;  (* Box *)

Procedure Delete(Row , Col : integer; var length : integer);
(* Deletes the last character entered into the box *)

Var
  TextColor : integer;

Begin (* Delete *)

  if length <> 0
  then
    begin
      TextColor := _GetTextColor;
      length := length - 1;
      _SetTextPosition(Row,Col + length);
      _SetTextColor(33);
      _OutText('.');
      _SetTextColor(TextColor);
      _SetTextPosition(Row,Col + length);
    end

End;  (* Delete *)

Procedure FadeBox(var color : Longint; var i : integer);
(* This procedure fades a box from blue to pink.
   Box is color 32 *)

var
  oldcolor : LongInt;

Begin (* FadeBox *)

  while (Not KeyPressed) do
    begin
      i := (i MOD 125) + 1;
      if ((i DIV 63) mod 2) = 0
      then
	color := color + $000001
      else
	color := color - $000001;
      oldcolor := _RemapPalette(32,color)
    end;

End;  (* FadeBox *)

Procedure Get_Users_Name(var Name : CString);
(* This Procedure Gets the users name unless ESC is pressed *)

Const
  MaxLength = 28;

Type
  NameType  = array[1..40] of char;

Var
  NameTemp    : NameType;
  color       : Longint;
  Col , Row , i ,
  length      : integer;
  buffer      : char;
  oldcursor   : boolean;

BEGIN (* Get_Users_Name *)

  Col := 3;
  Row := 10;
  oldcursor := _DisplayCursor(False);
  _SetTextColor(31);
  _SetTextPosition(Row-7,Col);
  _OutText('SLOT MACHINE SIMULATOR');
  _SetTextColor(30);
  _SetTextPosition(Row-2,Col);
  _OutText('Please Enter Your Name');
  _SetTextPosition(Row+2,Col);
  _OutText('<ESC> = QUIT Entering Your Name');
  Box(Row,Col,MaxLength);
  i      := 0;
  length := 0;
  color := $371e00;
  _SetTextColor(34);
  buffer := ' ';
  while (buffer <> ENTER) AND (buffer <> ESC) do
    begin
      FadeBox(color,i);
      buffer := ReadKey;
      _SetTextPosition(Row , Col + length);
      if (buffer <> ENTER) AND (buffer <> lf) AND (buffer <> ESC)
      then
	if (buffer = #0)
	then
	  begin
	    buffer := ReadKey;
	    if (buffer = Del) or (buffer = LeftArrow)
	    then
	      Delete(Row,Col,length);
	  end (* if *)
	else
	  begin
	    if (buffer = BS) or (buffer = CtrBS)
	    then
	      Delete(Row,Col,length)
	    else
	      begin
		if (length <> MaxLength)
		then
		  length := length + 1
		else
		  _SetTextPosition(Row , Col + length - 1);
		NameTemp[length] := buffer;
		_OutText(buffer);
		_SetTextPosition(Row , Col + length - 1)
	      end (* else *)
	  end (* else *)
      else
	if (length = 0) AND (buffer <> ESC)
	then
	  buffer := ' ';
    end; (* while *)
  Name := '';
  if (buffer <> ESC)
  then
    for i := 1 to length do
      Name := Name + NameTemp[i];
  _SetTextColor(15);

END;  (* Get_Users_Name *)

Procedure Get_NumSims(var NumSims : integer);
(* This Procedure Gets the number of simulations to be
   played unless ESC is pressed *)

Const
  MaxNumLength = 1;

Type
  NumSimsType = array[1..40] of char;

Var
  buffer      : char;
  NumSimsTemp : NumSimsType;
  color       : Longint;
  Col , Row ,
  i , length  : integer;
  oldcursor   : boolean;

Begin (* NumSims *)

  _ClearScreen(_GViewPort);
  oldcursor := _DisplayCursor(False);
  Col := 16;
  Row := 12;
  _SetTextColor(31);
  _SetTextPosition(Row-9,Col-8);
  _OutText('NUMBER OF SIMULATIONS');
  _SetTextColor(30);
  _SetTextPosition(Row-7,Col-8);
  _OutText('DEFAULT SIMULATIONS = 2');_SetTextPosition(Row-5,Col-8);
  _SetTextPosition(Row-5,Col-8);
  _OutText('Please Enter Your Number');
  _SetTextPosition(Row-3,Col-8);
  _OutText('of Simulations   (1 - 9)');
  _SetTextPosition(Row+5,Col-8);
  _OutText('HIT <ENTER> WHEN FINISHED');
  _SetTextPosition(Row+7,Col-8);
  _OutText('<ESC> = QUIT TO MAIN MENU');
  Box(Row,Col,MaxNumLength);
  i      := 0;
  length := 0;
  color := $371e00;
  _SetTextColor(34);
  buffer := ' ';
  while (buffer <> ENTER) AND (buffer <> ESC) do
    begin
      FadeBox(color,i);
      buffer := ReadKey;
      _SetTextPosition(Row , Col + length);
      if (buffer <> ENTER) AND (buffer <> lf)
      then
	if (buffer = #0)
	then
	  begin
	    buffer := ReadKey;
	    if (buffer = Del) or (buffer = LeftArrow)
	    then
	      Delete(Row,Col,length);
	  end (* if *)
	else
	  begin
	    if (buffer = BS) or (buffer = CtrBS)
	    then
	      Delete(Row,Col,length)
	    else
	      begin
		if (length <> MaxNumLength) and (buffer IN NumberSet)
		then
		  length := length + 1
		else
		  _SetTextPosition(Row , Col + length - 1);
		NumSimsTemp[length] := buffer;
		if (buffer IN NumberSet)
		then
		  _OutText(buffer);
		_SetTextPosition(Row , Col + length - 1)

	      end (* else *)
	  end (* else *)
      else
	if (length = 0)
	then
	  buffer := ' ';
    end; (* while *)
  if (buffer <> ESC)
  then
    begin
      NumSims := 0;
      for i := 1 to Length do
	NumSims := NumSims*10 + (Ord(NumSimsTemp[i]) - Ord('0'));
    end; (* if *)
  if NumSims = 0
  then
    NumSims := 2;
  _SetTextColor(15);

End;  (* NumSims *)

Procedure SetPage;
(* This procedure sets the MAIN MENU screen *)

Var
  row , col : integer;

Begin (* SetPage *)

  _ClearScreen(_GViewPort);
  row := 10;
  col := 5;
  _SetTextColor(31);
  _SetTextPosition(row-5,col);
  _OutText('---------MAIN  MENU---------');
  _SetTextColor(15);
  _SetTextPosition(row,col);
  _OutText('1) BEGIN SIMULATION---------');
  _SetTextPosition(row+1,col);
  _OutText('2) CHANGE STARTING CREDIT---');
  _SetTextPosition(row+2,col);
  _OutText('3) CHANGE NUMBER OF BETS----');
  _SetTextPosition(row+3,col);
  _OutText('4) LIST OPTIONS-------------');
  _SetTextPosition(row+4,col);
  _OutText('5) LIST PAYING COMBINATIONS-');
  _SetTextPosition(row+5,col);
  _OutText('6) SET SOUND----------------');
  _SetTextPosition(row+6,col);
  _OutText('7) SET DISPLAY--------------');
  _SetTextPosition(row+7,col);
  _OutText('8) QUIT <ESC> PROGRAM-------');
  _SetTextPosition(row+8,col);

End;  (* SetPage *)

Procedure FormatText(NumSims,CurSim,Credit : integer;
		     Name : CString; BetNum : integer);
(* This procedure Formats the text on the slot machine simulator *)

Var
  i : integer;
  StNum : CString;

Begin (* Format Text *)

  _SetTextPosition(3,3);
  _SetTextColor(6);
  _OutText('SLOT MACHINE SIMULATION No. = ');
  _SetTextPosition(3,33);
  Str(CurSim,StNum);
  _OutText(StNum);
  _SetTextPosition(3,35);
  _OutText('of');
  _SetTextPosition(3,38);
  Str(NumSims,StNum);
  _OutText(StNum);
  _SetTextPosition(5,3);
  _OutText(Name);

  _SetTextColor(7);
  _SetTextPosition(6,31);
  _OutText('CREDIT');
  _SetTextPosition(7,31);
  _OutText('000000');
  Str(Credit,StNum);
  _SetTextPosition(7,37-Length(StNum));
  _OutText(StNum);
  _SetTextPosition(9,31);
  _OutText('BET No.');
  _SetTextPosition(10,31);
  _OutText('000000');
  Str(BetNum,StNum);
  _SetTextPosition(10,37-Length(StNum));

  _SetTextColor(8);
  _SetTextPosition(12,3);
  _OutText('PAY');
  _SetTextPosition(14,3);
  _OutText('LINE');

  _SetTextColor(9);
  _SetTextPosition(23,3);
  _OutText('BET');
  _SetTextPosition(25,8);
  _OutText('<ESC> = QUIT TO MAIN MENU');

  For i := 1 to 5 do
    begin
      _SetTextColor(i);
      _SetColor(i);
      _SetTextPosition(23,4*i + 4);
      Str(i,StNum);
      _OutText(StNum);
      _Rectangle(_GBorder,32*i + 16,169,32*i + 38,190);
      _Rectangle(_GBorder,32*i + 19,172,32*i + 35,187);
    end; (* for *)

End;  (* Format Text *)

Procedure Random_Wheels(Name : CString; NumSims : integer;
			var Credit : integer; NumOfBets : integer;
			var BetNum : integer;
			var Scrolling , Snd , Fast : boolean);
(* This procedure runs a simulation *)

TYPE
  WheelSet  = (Left,Centre,Right) ;
  Position  = 1..11 ;
  ItemType  = (Bar,Bell,Cherry,Orange,Plum) ;
  WheelType = Array[Left..Right,Position] of ItemType ;
  PositionType = Array[Left..Right] of Position ;

VAR
  Place ,
  LastPlace  : PositionType ;
  Wheel      : WheelType ;
  Column     : WheelSet;
  buffer     : char ;
  WIN        : boolean;
  color ,
  oldcolor   : LongInt;
  Bet , x ,
  y , PayOff : integer;
  StNum      : CString;

Procedure SetWheels(VAR Wheel : WheelType);
(* This procedure sets the slot machine's 3 wheels and assigns
   the 11 positions various items *)

Begin (* SetWheels *)

  (* Left Wheel *)
  Wheel[Left,1]  := Bar    ;
  Wheel[Left,2]  := Bell   ;
  Wheel[Left,3]  := Cherry ;
  Wheel[Left,4]  := Orange ;
  Wheel[Left,5]  := Plum   ;
  Wheel[Left,6]  := Cherry ;
  Wheel[Left,7]  := Orange ;
  Wheel[Left,8]  := Cherry ;
  Wheel[Left,9]  := Plum   ;
  Wheel[Left,10] := Bar    ;
  Wheel[Left,11] := Cherry ;

  (* Centre Wheel *)
  Wheel[Centre,1]  := Cherry ;
  Wheel[Centre,2]  := Orange ;
  Wheel[Centre,3]  := Plum   ;
  Wheel[Centre,4]  := Cherry ;
  Wheel[Centre,5]  := Bar    ;
  Wheel[Centre,6]  := Bell   ;
  Wheel[Centre,7]  := Orange ;
  Wheel[Centre,8]  := Bar    ;
  Wheel[Centre,9]  := Plum   ;
  Wheel[Centre,10] := Bell   ;
  Wheel[Centre,11] := Plum   ;

  (* Right Wheel *)
  Wheel[Right,1]  := Plum   ;
  Wheel[Right,2]  := Cherry ;
  Wheel[Right,3]  := Bell   ;
  Wheel[Right,4]  := Orange ;
  Wheel[Right,5]  := Bar    ;
  Wheel[Right,6]  := Cherry ;
  Wheel[Right,7]  := Plum   ;
  Wheel[Right,8]  := Orange ;
  Wheel[Right,9]  := Cherry ;
  Wheel[Right,10] := Cherry ;
  Wheel[Right,11] := Orange ;

End;  (* SetWheels *)

Procedure GetRandPositions(VAR Place : PositionType);
(* Updates the next random position *)

VAR
  Column : WheelSet ;

Begin (* GetRandPositions *)

  For Column := Left to Right do (* Set New Random Position *)
    Place[Column] := ((Place[Column] + (Random(11) + 1)) MOD 11) + 1 ;

End;  (* GetRandPositions *)

Procedure CheckForWin( Wheel : WheelType    ; Place  : PositionType ;
		       VAR PayOff : integer ; VAR WIN : boolean);
(* Checks the current place if it satisfies a set winning combination
   and sets the Payoff and WIN *)

Begin (* CheckForWin *)

  WIN := False ;
  PayOff := 0 ;
  if ( Wheel[Left ,Place[Left]]  = Cherry ) or
     ( Wheel[Right,Place[Right]] = Cherry )
  then
    begin (* Winning Combination *)
      if ( Wheel[Centre,Place[Centre]] = Cherry )
      then (* Decent Win *)
	begin
	  PayOff := 5 ;
	  WIN := True ;
	end (* if *)
      else (* Small Win *)
	begin
	  PayOff := 2 ;
	  WIN := True ;
	end; (* else *)
    end; (* if CHERRY *)

  if ( Wheel[Left  ,Place[Left]]   = Plum ) and
     ( Wheel[Centre,Place[Centre]] = Plum ) and
     ( Wheel[Right ,Place[Right]]  = Plum )
  then
    begin (* Winning Combination *)
      PayOff := 10 ;
      WIN := True  ;
    end; (* if *)

  if ( Wheel[Left  ,Place[Left]]   = Orange ) and
     ( Wheel[Centre,Place[Centre]] = Orange ) and
     ( Wheel[Right ,Place[Right]]  = Orange )
  then
    begin (* Winning Combination *)
      PayOff := 14 ;
      WIN := True  ;
    end; (* if *)

  if ( Wheel[Left  ,Place[Left]]   = Bell ) and
     ( Wheel[Centre,Place[Centre]] = Bell ) and
     ( Wheel[Right ,Place[Right]]  = Bell )
  then
    begin (* Winning Combination *)
      PayOff := 20 ;
      WIN := True  ;
    end; (* if *)

  if ( Wheel[Left  ,Place[Left]]   = Bell ) and
     ( Wheel[Centre,Place[Centre]] = Bar  ) and
     ( Wheel[Right ,Place[Right]]  = Bell )
  then
    begin (* Winning Combination *)
      PayOff := 25 ;
      WIN := True  ;
    end; (* if *)

  if ( Wheel[Left  ,Place[Left]]   = Bar  ) and
     ( Wheel[Centre,Place[Centre]] = Bar  ) and
     ( Wheel[Right ,Place[Right]]  = Bar  )
  then
    begin (* Winning Combination *)
      PayOff := 50 ;
      WIN := True  ;
    end; (* if *)

End;  (* CheckForWin *)

Procedure ColorBet(color : integer);
(* This procedure turns the appropriate number on the simulation
   screen yellow after the user enter's a valid bet *)

Var
  oldcolor : LongInt;
  i : integer;

Begin (* ColorBet *)

  For i := 1 to 5 do
    if i <> color
    then
      oldcolor := _RemapPalette(i,$3f3f3f); (* White *)
  oldcolor := _RemapPalette(color,$003f3f); (* Yellow *)

End;  (* ColorBet *)

Procedure GetBoxImage(xLength , y : integer;
		      var Image : ImageType;
		      var Size  : Word ;BoxNum : integer);
(* This Procedure stores a selected portion of the screen to be
   scrolled down *)

Var
  x , yLength : integer;

Begin (* Get Box Image *)

  Case BoxNum of
    1 : x := xLength - 120;
    2 : x := xLength - 80;
    3 : x := xLength - 40;
  End; (* Case *)
  yLength := y + 120;
  Size := _ImageSize(x,y,xLength,yLength);
  GetMem(Image , Size);
  _GetImage(x,y,xLength,yLength,Image^);

End;  (* Get Box Image *)

Procedure SetScreen(Column : WheelSet; Place : PositionType;
		       Wheel : WheelType;
		       x,y : integer);
(* This procedure sets the initial positions of the pictures *)

Var
  temp : integer;

Begin (* Set Screen *)
  temp := x;
  For Column := Left to Right do
    begin
      CASE Wheel[Column,((Place[Column]+9) MOD 11)+1] of
	Bar    : _PutImage(x,y-40,BarImage^,_GPSET);
	Bell   : _PutImage(x,y-40,BellImage^,_GPSET);
	Cherry : _PutImage(x,y-40,CherryImage^,_GPSET);
	Orange : _PutImage(x,y-40,OrangeImage^,_GPSET);
	Plum   : _PutImage(x,y-40,PlumImage^,_GPSET);
      End; (* CASE *)
      x := x + 40;
    end; (* for *)
  x := temp;
  For Column := Left to Right do
    begin
      CASE Wheel[Column,Place[Column]] of
	Bar    : _PutImage(x,y,BarImage^,_GPSET);
	Bell   : _PutImage(x,y,BellImage^,_GPSET);
	Cherry : _PutImage(x,y,CherryImage^,_GPSET);
	Orange : _PutImage(x,y,OrangeImage^,_GPSET);
	Plum   : _PutImage(x,y,PlumImage^,_GPSET);
      End; (* CASE *)
      x := x + 40;
    end; (* for *)
  x := temp;
  For Column := Left to Right do
    begin
      CASE Wheel[Column,(Place[Column] MOD 11)+1] of
	Bar    : _PutImage(x,y+40,BarImage^,_GPSET);
	Bell   : _PutImage(x,y+40,BellImage^,_GPSET);
	Cherry : _PutImage(x,y+40,CherryImage^,_GPSET);
	Orange : _PutImage(x,y+40,OrangeImage^,_GPSET);
	Plum   : _PutImage(x,y+40,PlumImage^,_GPSET);
      End; (* CASE *)
      x := x + 40;
    end; (* for *)

End;  (* Set Screen *)

Procedure ScrollScreenFast(Column : WheelSet;
			   Place,LastPlace: PositionType;
			   Wheel : WheelType;
			   x,y : integer);
{ Fast Scrolling procedure }
var
  temp : integer;

Begin (* Scroll Screen Fast *)

  temp := x;
  Repeat
      if (LastPlace[Left] <> Place[Left])
      then
	begin
	  LastPlace[Left]   := ((LastPlace[Left]+9) MOD 11) + 1;
	  LastPlace[Centre] := ((LastPlace[Centre]+9) MOD 11) + 1;
	  LastPlace[Right]  := ((LastPlace[Right]+9) MOD 11) + 1;
	end; (* if *)
      if (LastPlace[Centre] <> Place[Centre]) and
	 (LastPlace[Left] = Place[Left])
      then
	begin
	  LastPlace[Centre] := ((LastPlace[Centre]+9) MOD 11) + 1;
	  LastPlace[Right]  := ((LastPlace[Right]+9) MOD 11) + 1;
	end; (* if *)
      if (LastPlace[Right] <> Place[Right]) and
	 (LastPlace[Centre] = Place[Centre]) and
	 (LastPlace[Left] = Place[Left])
      then
	begin
	  LastPlace[Right]  := ((LastPlace[Right]+9) MOD 11) + 1;
	end; (* if *)

  For Column := Left to Right do
    begin
      CASE Wheel[Column,(((LastPlace[Column]+9) MOD 11)+1)] of
	Bar    : Begin
		   _PutImage(x,y-40,BarImage^,_GPSET);
		 End; (* Bar *)
	Bell   : Begin
		   _PutImage(x,y-40,BellImage^,_GPSET);
		 End; (* Bell *)
	Cherry : Begin
		   _PutImage(x,y-40,CherryImage^,_GPSET);
		 End; (* Cherry *)
	Orange : Begin
		   _PutImage(x,y-40,OrangeImage^,_GPSET);
		 End; (* Orange *)
	Plum   : Begin
		   _PutImage(x,y-40,PlumImage^,_GPSET);
		 End; (* Plum *)

      End; (* CASE *)
      x := x + 40;

    end; (* for *)
  x := temp;
  For Column := Left to Right do
    begin
      CASE Wheel[Column,LastPlace[Column]] of
	Bar    : Begin
		   _PutImage(x,y,BarImage^,_GPSET);
		 End; (* Bar *)
	Bell   : Begin
		   _PutImage(x,y,BellImage^,_GPSET);
		 End; (* Bell *)
	Cherry : Begin
		   _PutImage(x,y,CherryImage^,_GPSET);
		 End; (* Cherry *)
	Orange : Begin
		   _PutImage(x,y,OrangeImage^,_GPSET);
		 End; (* Orange *)
	Plum   : Begin
		   _PutImage(x,y,PlumImage^,_GPSET);
		 End; (* Plum *)

      End; (* CASE *)
      x := x + 40;

    end; (* for *)
  x := temp;
  For Column := Left to Right do
    begin
      CASE Wheel[Column,(((LastPlace[Column]) MOD 11) + 1)] of
	Bar    : Begin
		   _PutImage(x,y+40,BarImage^,_GPSET);
		 End; (* Bar *)
	Bell   : Begin
		   _PutImage(x,y+40,BellImage^,_GPSET);
		 End; (* Bell *)
	Cherry : Begin
		   _PutImage(x,y+40,CherryImage^,_GPSET);
		 End; (* Cherry *)
	Orange : Begin
		   _PutImage(x,y+40,OrangeImage^,_GPSET);
		 End; (* Orange *)
	Plum   : Begin
		   _PutImage(x,y+40,PlumImage^,_GPSET);
		 End; (* Plum *)

      End; (* CASE *)
      x := x + 40;

    end; (* for *)
    x := temp;
    UNTIL (LastPlace[Left] = Place[Left])   and
	(LastPlace[Centre] = Place[Centre]) and
	(LastPlace[Right]  = Place[Right]) ;

End;  (* Scroll Screen Fast *)

Procedure ScrollScreen(Column : WheelSet; Place,LastPlace: PositionType;
		       Wheel : WheelType;
		       x,y : integer);
Var
  temp,BoxNum,i : integer;

Begin (* Scroll Screen *)

  temp := x;
  BoxNum := 1;
  While (LastPlace[Left] <> Place[Left]) do
    begin
      For i := 1 to 10 do
	begin
	  GetBoxImage(temp+120,y-41,DisplayBox1,DisplaySize1,BoxNum);
	  _PutImage(temp+(40*(BoxNum-1)),y-40,DisplayBox1^,_GPSET);
	  FreeMem(DisplayBox1,DisplaySize1);
	end; (* for *)
      For i := 30 downto 1 do
	begin
	  For Column := Left to Right do
	    begin
	      x := Ord(Column)*40 + temp;
	      CASE Wheel[Column,(((LastPlace[Column]+8) MOD 11)+1)] of
		Bar    : _PutImage(x,y-40,SplitBar.Line[i]^,_GPSET);
		Bell   : _PutImage(x,y-40,SplitBell.Line[i]^,_GPSET);
		Cherry : _PutImage(x,y-40,SplitCherry.Line[i]^,_GPSET);
		Orange : _PutImage(x,y-40,SplitOrange.Line[i]^,_GPSET);
		Plum   : _PutImage(x,y-40,SplitPlum.Line[i]^,_GPSET);
	      End; (* CASE *)
	    end; (* for column *)
	  x := temp;
	  GetBoxImage(temp+120,y-41,DisplayBox1,DisplaySize1,BoxNum);
	  _PutImage(temp+(40*(BoxNum-1)),y-40,DisplayBox1^,_GPSET);
	  FreeMem(DisplayBox1,DisplaySize1);
	end; (* for i *)
	LastPlace[Left]   := ((LastPlace[Left] +  9) MOD 11) + 1;
	LastPlace[Centre] := ((LastPlace[Centre]+ 9) MOD 11) + 1;
	LastPlace[Right]  := ((LastPlace[Right] + 9) MOD 11) + 1;
    end; (* while *)

  BoxNum := 2;
  While (LastPlace[Centre] <> Place[Centre]) do
    begin
      For i := 1 to 10 do
	begin
	  GetBoxImage(temp+120,y-41,DisplayBox1,DisplaySize1,BoxNum);
	  _PutImage(temp+(40*(BoxNum-1)),y-40,DisplayBox1^,_GPSET);
	  FreeMem(DisplayBox1,DisplaySize1);
	end; (* for *)
      For i := 30 downto 1 do
	Begin
	  For Column := Centre to Right do
	    begin
	      x := Ord(Column)*40 + temp;
	      CASE Wheel[Column,(((LastPlace[Column]+8) MOD 11)+1)] of
		Bar    : _PutImage(x,y-40,SplitBar.Line[i]^,_GPSET);
		Bell   : _PutImage(x,y-40,SplitBell.Line[i]^,_GPSET);
		Cherry : _PutImage(x,y-40,SplitCherry.Line[i]^,_GPSET);
		Orange : _PutImage(x,y-40,SplitOrange.Line[i]^,_GPSET);
		Plum   : _PutImage(x,y-40,SplitPlum.Line[i]^,_GPSET);
	      End; (* CASE *)
	    end; (* for column *)
	  x := temp;
	  GetBoxImage(temp+120,y-41,DisplayBox1,DisplaySize1,BoxNum);
	  _PutImage(temp+(40*(BoxNum-1)),y-40,DisplayBox1^,_GPSET);
	  FreeMem(DisplayBox1,DisplaySize1);
	end; (* for i *)
      LastPlace[Centre] := ((LastPlace[Centre]+9) MOD 11) + 1;
      LastPlace[Right]  := ((LastPlace[Right]+9) MOD 11) + 1;
    end; (* while *)

  BoxNum := 3;
  While (LastPlace[Right] <> Place[Right]) do
    begin
      For i := 1 to 10 do
	begin
	  GetBoxImage(temp+120,y-41,DisplayBox1,DisplaySize1,BoxNum);
	  _PutImage(temp+(40*(BoxNum-1)),y-40,DisplayBox1^,_GPSET);
	  FreeMem(DisplayBox1,DisplaySize1);
	end; (* for *)
      For i := 30 downto 1 do
	begin
	  For Column := Right to Right do
	    begin
	      x := Ord(Column)*40 + temp;
	      CASE Wheel[Column,(((LastPlace[Column]+8) MOD 11)+1)] of
		Bar    : _PutImage(x,y-40,SplitBar.Line[i]^,_GPSET);
		Bell   : _PutImage(x,y-40,SplitBell.Line[i]^,_GPSET);
		Cherry : _PutImage(x,y-40,SplitCherry.Line[i]^,_GPSET);
		Orange : _PutImage(x,y-40,SplitOrange.Line[i]^,_GPSET);
		Plum   : _PutImage(x,y-40,SplitPlum.Line[i]^,_GPSET);
	      End; (* CASE *)
	    end; (* for column *)
	  x := temp;
	  GetBoxImage(temp+120,y-41,DisplayBox1,DisplaySize1,BoxNum);
	  _PutImage(temp+(40*(BoxNum-1)),y-40,DisplayBox1^,_GPSET);
	  FreeMem(DisplayBox1,DisplaySize1);
	end; (* for i *)
      LastPlace[Right]  := ((LastPlace[Right]+9) MOD 11) + 1;
    end; (* while *)

End;  (* Scroll Screen *)

Procedure SimpleDisplay(Column : WheelSet; Place  : PositionType;
			Wheel : WheelType;
			x,y : integer);
(* This Procedure only shows the middle line of pictures *)

Begin (* SimpleDisplay *)

  For Column := Left to Right do
    begin
      CASE Wheel[Column,Place[Column]] of
	Bar    : _PutImage(x,y,BarImage^,_GPSET);
	Bell   : _PutImage(x,y,BellImage^,_GPSET);
	Cherry : _PutImage(x,y,CherryImage^,_GPSET);
	Orange : _PutImage(x,y,OrangeImage^,_GPSET);
	Plum   : _PutImage(x,y,PlumImage^,_GPSET);
      End; (* CASE *)
      x := x + 40;
    end; (* for *)

End;  (* SimpleDisplay *)

BEGIN (* Random_Wheels *)

  _SetTextColor(32);
  _SetTextPosition(14,29);
  _OutText('Randomizing');
  (* Initialise Wheel Positions to 2 *)
  Place[Left]   := 2 ;
  Place[Centre] := 2 ;
  Place[Right]  := 2 ;
  Str(Credit,StNum);
  _SetTextPosition(7,37-Length(StNum));
  _OutText(StNum);
  SetWheels(Wheel);
  _SetTextColor(15);
  x := 60;
  y := 82;
  if scrolling
  then
    SetScreen(Column,Place,Wheel,x,y);
  buffer := 'r';
  While (buffer <> 'x') and (buffer <> ESC) do
    begin
      if buffer IN BetSet
      then
	begin
	  Bet := Ord(buffer) - Ord('0');
	  BetNum := BetNum + 1;
	  ColorBet(Bet);
	end (* if *)
      else
	Bet := 0;
      if (buffer = 'r') or (buffer = 'R')
      then
	Randomize;
      LastPlace := Place;
      GetRandPositions(Place);
      x := 60;
      y := 82;
      if scrolling
      then
	if Fast
	then
	  ScrollScreenFast(Column,Place,LastPlace,Wheel,x,y)
	else
	  ScrollScreen(Column,Place,LastPlace,Wheel,x,y)
      else
	SimpleDisplay(Column,Place,Wheel,x,y);
      CheckForWin(Wheel,Place,PayOff,WIN);
      if WIN
      then
	begin
	  Str(payoff*bet,StNum);
	  _SetTextPosition(12,31);
	  _OutText('WIN = ' + StNum + '  ');
	  if Snd
	  then
	    begin
	      Sound(100);Delay(100);
	      oldcolor := _RemapPalette(15,$3f0000);
	      Sound(500);Delay(25);
	      oldcolor := _RemapPalette(15,$00003f);
	      Sound(550);Delay(25);
	      oldcolor := _RemapPalette(15,$003f00);
	      Sound(600);Delay(25);
	      oldcolor := _RemapPalette(15,$003f3f);
	      Sound(650);Delay(25);
	      oldcolor := _RemapPalette(15,$3f3f00);
	      Sound(800);Delay(50);
	      oldcolor := _RemapPalette(15,$3f3f3f);
	      NoSound
	    end (* if Sound *)
	end (* if *)
      else
	begin
	  _SetTextPosition(12,31);
	  _OutText('            ');
	end; (* else *)
      Credit := Credit - Bet + (Bet * PayOff);
      Str(Credit,StNum);
      _SetTextPosition(7,36-Length(StNum));
      _OutText('0' + StNum);
      Str(BetNum,StNum);
      _SetTextPosition(10,37-Length(StNum));
      _OutText(StNum);
      if Credit > 0
      then
	if BetNum < NumOfBets
	then
	  begin
	    _SetTextColor(10);
	    _SetTextPosition(14,29);
	    _OutText('  PLEASE   ');
	    _SetTextPosition(15,29);
	    _OutText('  ENTER');
	    _SetTextPosition(16,29);
	    _OutText('  A BET');
	    _SetTextColor(15);
	    while (Not KeyPressed) do
	      Begin
		i := i MOD 25 + 1;
		color := $250025 + i ;
		oldcolor := _RemapPalette(10,(color));
	      End; (* while *)
	    buffer := ReadKey
	  end
	else
	  begin
	    _SetTextPosition(25,8);
	    _OutText('Press any key to continue...');
	    CurSim := CurSim + 1;
	    BetNum := 0;
	    Credit := 50;
	    buffer := ReadKey;
	    buffer := ESC;
	  end (* else *)
      else
	begin
	  _SetTextPosition(25,8);
	  _OutText('Press any key to continue...');
	  CurSim := CurSim + 1;
	  Credit := 50;
	  buffer := ReadKey;
	  buffer := ESC;
	end; (* else *)
    end; (* while not ESC *)

END;  (* Random_Wheels *)

Procedure Menu2(var Credit : integer);
(* This procedure prompts the user to change their credit *)

Const
  MaxNumLength = 4;

Type
  CreditType = array[1..40] of char;

Var
  buffer     : char;
  CreditTemp : CreditType;
  color      : Longint;
  Col , Row ,
  i , length : integer;

Begin (* Menu2 *)

  _ClearScreen(_GViewPort);
  Col := 16;
  Row := 12;
  _SetTextColor(31);
  _SetTextPosition(Row-9,Col-8);
  _OutText('CHANGE STARTING CREDIT');
  _SetTextColor(30);
  _SetTextPosition(Row-7,Col-8);
  _OutText('DEFAULT CREDIT = 50');
  _SetTextPosition(Row-5,Col-8);
  _OutText('Please Enter Your Starting');
  _SetTextPosition(Row-3,Col-8);
  _OutText('Credit Between  (1 - 9999)');
  _SetTextPosition(Row+5,Col-8);
  _OutText('HIT <ENTER> WHEN FINISHED');
  _SetTextPosition(Row+7,Col-8);
  _OutText('<ESC> = QUIT TO MAIN MENU');
  Box(Row,Col,MaxNumLength);
  i         := 0;
  length    := 0;
  color     := $371e00;
  buffer    := ' ';
  _SetTextColor(34);
  while (buffer <> ENTER) AND (buffer <> ESC) do
    begin
      FadeBox(color,i);
      buffer := ReadKey;
      _SetTextPosition(Row , Col + length);
      if (buffer <> ENTER) AND (buffer <> lf)
      then
	if (buffer = #0)
	then
	  begin
	    buffer := ReadKey;
	    if (buffer = Del) or (buffer = LeftArrow)
	    then
	      Delete(Row,Col,length);
	  end (* if *)
	else
	  begin
	    if (buffer = BS) or (buffer = CtrBS)
	    then
	      Delete(Row,Col,length)
	    else
	      begin
		if (length <> MaxNumLength) and (buffer IN NumberSet)
		then
		  length := length + 1
		else
		  _SetTextPosition(Row , Col + length - 1);
		CreditTemp[length] := buffer;
		if (buffer IN NumberSet)
		then
		  _OutText(buffer);
		_SetTextPosition(Row , Col + length - 1)

	      end (* else *)
	  end (* else *)
      else
	if (length = 0)
	then
	  buffer := ' ';
    end; (* while *)
  if (buffer <> ESC)
  then
    begin
      Credit := 0;
      for i := 1 to Length do
	Credit := Credit*10 + (Ord(CreditTemp[i]) - Ord('0'));
    end;
  if Credit = 0
  then
    Credit := 50;
  Str(Credit,StNum);
  _SetTextPosition(1,1);
  _SetTextColor(15);
  SetPage;

End;  (* Menu2 *)

Procedure Menu3(var NumOfBets : integer);
(* This procedure prompts the user to change their number of bets *)

Const
  MaxNumLength = 3;

Type
  BetType = array[1..40] of char;

Var
  buffer     : char;
  BetTemp    : BetType;
  color      : Longint;
  Col , Row ,
  i , length : integer;

Begin (* Menu3 *)

  _ClearScreen(_GViewPort);
  Col := 16;
  Row := 12;
  _SetTextColor(31);
  _SetTextPosition(Row-9,Col-8);
  _OutText('CHANGE NUMBER OF BETS');
  _SetTextColor(30);
  _SetTextPosition(Row-7,Col-8);
  _OutText('DEFAULT BETS = 100');
  _SetTextPosition(Row-5,Col-8);
  _OutText('Please Enter Your Starting');
  _SetTextPosition(Row-3,Col-8);
  _OutText('Number of Bets   (1 - 999)');
  _SetTextPosition(Row+5,Col-8);
  _OutText('HIT <ENTER> WHEN FINISHED');
  _SetTextPosition(Row+7,Col-8);
  _OutText('<ESC> = QUIT TO MAIN MENU');
  Box(Row,Col,MaxNumLength);
  i      := 0;
  length := 0;
  color  := $371e00;
  buffer := ' ';
  _SetTextColor(34);
  while (buffer <> ENTER) AND (buffer <> ESC) do
    begin
      FadeBox(color,i);
      buffer := ReadKey;
      _SetTextPosition(Row , Col + length);
      if (buffer <> ENTER) AND (buffer <> lf)
      then
	if (buffer = #0)
	then
	  begin
	    buffer := ReadKey;
	    if (buffer = Del) or (buffer = LeftArrow)
	    then
	      Delete(Row,Col,length);
	  end (* if *)
	else
	  begin
	    if (buffer = BS) or (buffer = CtrBS)
	    then
	      Delete(Row,Col,length)
	    else
	      begin
		if (length <> MaxNumLength) and (buffer IN NumberSet)
		then
		  length := length + 1
		else
		  _SetTextPosition(Row , Col + length - 1);
		BetTemp[length] := buffer;
		if (buffer IN NumberSet)
		then
		  _OutText(buffer);
		_SetTextPosition(Row , Col + length - 1)

	      end (* else *)
	  end (* else *)
      else
	if (length = 0)
	then
	  buffer := ' ';
    end; (* while *)
  if (buffer <> ESC)
  then
    begin
      NumOfBets := 0;
      for i := 1 to Length do
	NumOfBets := NumOfBets*10 + (Ord(BetTemp[i]) - Ord('0'));
    end;
  if NumOfBets = 0
  then
    NumOfBets := 100;
  _SetTextColor(15);
  SetPage;

End;  (* Menu3 *)

Procedure Menu4(NumSims,Credit,NumOfBets : integer;
		Scrolling,Snd,Fast : boolean);
(* This procedure shows all the current option settings *)

Var
  Row , Col : integer;
  buffer : char;

Begin (* Menu4 *)

  _ClearScreen(_GViewPort);
  Row := 3;
  Col := 8;
  _SetTextColor(31);
  _SetTextPosition(Row,Col);
  _OutText('LISTING OF OPTIONS');
  _SetTextColor(30);
  _SetTextPosition(Row+4,Col);
  _OutText('NUMBER OF BETS');
  _SetTextPosition(Row+6,Col);
  Str(NumOfBets,StNum);
  _OutText('PER SIMULATION        = ' + StNum);
  _SetTextPosition(Row+8,Col);
  Str(NumSims,StNum);
  _OutText('NUMBER OF SIMULATIONS = ' + StNum);
  _SetTextPosition(Row+10,Col);
  Str(Credit,StNum);
  _OutText('NUMBER OF CREDITS     = ' + StNum);
  _SetTextPosition(Row+12,Col);
  if Snd
  then
    _OutText('SOUND                 = ON')
  else
    _OutText('SOUND                 = OFF');
  _SetTextPosition(Row+14,Col);
  if Scrolling
  then
    if fast
    then
      _OutText('DISPLAY TYPE     = SCROLLING FAST')
    else
      _OutText('DISPLAY TYPE     = SCROLLING SLOW')
  else
    _OutText('DISPLAY TYPE          = SIMPLE');

  _SetTextPosition(Row+18,Col);
  _OutText('<ESC> = QUIT TO MAIN MENU');
  buffer := ' ';
  While (buffer <> ESC) and (buffer <> ENTER) do
    begin
      buffer := ReadKey;
      if (ord(buffer) = 0)
      then
	begin
	  buffer := ReadKey;
	end; (* if *)
    end; (* while *)
  _SetTextColor(15);
  SetPage;

End;  (* Menu4 *)

Procedure Menu5;
(* This Procedure Lists the paying combinations by showing
   three display pages *)

Var
  i , j ,Row , Col , x , y , right , down : integer;
  buffer : char;

Procedure Page1(Row,Col,x,y,i,j,right,down : integer);

Begin (* Page1 *)

  _SetTextPosition(Row+5,Col+20);
  _OutText('2 CREDITS');
  _SetTextPosition(Row+9,Col+20);
  _OutText('2 CREDITS');
  _SetTextPosition(Row+13,Col+20);
  _OutText('2 CREDITS');
  _SetTextPosition(Row+17,Col+20);
  _OutText('5 CREDITS');
  right := 49;
  down  := 32;
  x := 20;
  y := 29;
  For j := 0 to 3 do
    For i := 0 to 2 do
      if Not((j = 0) and (i = 0)) and
	 Not((j = 0) and (i = 1)) and
	 Not((j = 1) and (i = 1)) and
	 Not((j = 1) and (i = 2)) and
	 Not((j = 2) and (i = 1)) and
	 Not((j = 3) and (i = 2)) and
	 Not((j = 4) and (i = 0))
      then
	_PutImage(x+right*i,y+down*j,CherryImage^,_GPSET);


End;  (* Page1 *)

Procedure Page2(Row,Col,x,y,i,j,right,down : integer);

Begin (* Page2 *)

  _SetTextPosition(Row+5,Col+20);
  _OutText('5 CREDITS');
  _SetTextPosition(Row+9,Col+20);
  _OutText('5 CREDITS');
  _SetTextPosition(Row+13,Col+20);
  _OutText('10 CREDITS');
  _SetTextPosition(Row+17,Col+20);
  _OutText('14 CREDITS');
  right := 49;
  down  := 32;
  x := 20;
  y := 29;
  For j := 0 to 1 do
    For i := 0 to 2 do
      if Not((j = 0) and (i = 0))
      then
	_PutImage(x+right*i,y+down*j,CherryImage^,_GPSET);
  j := 2 ;
    For i := 0 to 2 do
      _PutImage(x+right*i,y+down*j,PlumImage^,_GPSET);
  j := 3 ;
    For i := 0 to 2 do
      _PutImage(x+right*i,y+down*j,OrangeImage^,_GPSET);

End;  (* Page2 *)

Procedure Page3(Row,Col,x,y,i,j,right,down : integer);

Begin (* Page3 *)

  _SetTextPosition(Row+5,Col+20);
  _OutText('20 CREDITS');
  _SetTextPosition(Row+9,Col+20);
  _OutText('25 CREDITS');
  _SetTextPosition(Row+13,Col+20);
  _OutText('50 CREDITS');
  right := 49;
  down  := 32;
  x := 20;
  y := 29;
  For j := 0 to 2 do
    For i := 0 to 2 do
      if Not ((j = 1) and (i = 1)) and
	 Not ((j = 2) and (i = 0)) and
	 Not ((j = 2) and (i = 1)) and
	 Not ((j = 2) and (i = 2))
      then
	_PutImage(x+right*i,y+down*j,BellImage^,_GPSET)
      else
	_PutImage(x+right*i,y+down*j,BarImage^,_GPSET);

End;  (* Page3 *)

Begin (* Menu5 *)

  i := 0;
  buffer := ' ';
  While (buffer <> ESC) do
    begin
      _ClearScreen(_GViewPort);
      Row := 1;
      Col := 4;
      _SetTextColor(31);
      _SetTextPosition(Row,Col);
      _OutText('LIST PAYING COMBINATIONS');
      _SetTextColor(30);
      _SetTextPosition(Row+2,Col);
      _OutText('LEFT CENTRE RIGHT | AMOUNT OF PAYOFF');
      _SetTextPosition(Row+22,Col);
      _OutText('Press any key for next page...');
      _SetTextPosition(Row+24,Col);
      _OutText('<ESC> = QUIT TO MAIN MENU');
      i := (i MOD 3) + 1;
      Case i of
	1 : Page1(Row,Col,x,y,i,j,right,down);
	2 : Page2(Row,Col,x,y,i,j,right,down);
	3 : Page3(Row,Col,x,y,i,j,right,down);
      end; (* case *)
      buffer := ReadKey;
      if (ord(buffer) = 0)
      then
	begin
	  buffer := ReadKey;
	end; (* if *)

    end; (* while *)
  _SetTextColor(15);
  SetPage;

End;  (* Menu5 *)

Procedure Menu7b(var Fast : boolean);
(* This Procedure is called if the user wants the screen to scroll
   and it sets the scrolling rate (Fast or Slow) *)

Const
  LetterLength = 1;

Type
  NameType     = array[1..40] of char;

Var
  NameTemp     : NameType;
  color        : Longint;
  Col , Row ,
  i , length   : integer;
  buffer       : char;

Begin (* Menu7b *)

  _ClearScreen(_GViewPort);
  row := 12;
  col := 19;
  _SetTextColor(31);
  _SetTextPosition(row-9,col-11);
  _OutText('SET SCROLLING');
  _SetTextColor(30);
  _SetTextPosition(row-7,col-11);
  _OutText('DEFAULT = SCROLLING SLOW');
  _SetTextPosition(row-5,col-11);
  _OutText('Do you wish to have the display');
  _SetTextPosition(row-3,col-11);
  _OutText('scrolling fast ?          (Y/N)');
  _SetTextPosition(Row+5,Col-11);
  _OutText('HIT <ENTER> WHEN FINISHED');
  _SetTextPosition(row+7,col-11);
  _OutText('<ESC> = QUIT TO MAIN MENU');
  Box(Row,Col,LetterLength);
  i      := 0;
  length := 0;
  color  := $371e00;
  buffer := ' ';
  _SetTextColor(34);
  while (buffer <> ENTER) AND (buffer <> ESC) do
    begin
      FadeBox(color,i);
      buffer := ReadKey;
      _SetTextPosition(Row , Col + length);
      if (buffer <> ENTER) AND (buffer <> lf)
      then
	if (buffer = #0)
	then
	  begin
	    buffer := ReadKey;
	    if (buffer = Del) or (buffer = LeftArrow)
	    then
	      Delete(Row,Col,length);
	  end (* if *)
	else
	  begin
	    if (buffer = BS) or (buffer = CtrBS)
	    then
	      Delete(Row,Col,length)
	    else
	      begin
		if (buffer IN Menu6Set)
		then
		  begin
		    if length <> LetterLength
		    then
		      length := length + 1;
		    NameTemp[length] := buffer;
		    if length <> 0
		    then
		      _SetTextPosition(Row , Col + length - 1);
		    _OutText(buffer);
		  end (* if *)
		else
		  _SetTextPosition(Row , Col + length - 1);
	      end (* else *)
	  end (* else *)
      else
	if (length = 0)
	then
	  buffer := ' ';
    end; (* while *)
  Name := '';
  if (buffer <> ESC)
  then
    Case NameTemp[1] of
	    'y','Y' : Fast := true;
	    'n','N' : Fast := false;
    End; (* Case *)

End;  (* Menu7b *)

Procedure Menu6(var Snd : boolean);

Const
  LetterLength = 1;

Type
  NameType     = array[1..40] of char;

Var
  NameTemp     : NameType;
  color        : Longint;
  Col , Row ,
  i , length   : integer;
  buffer       : char;

Begin (* Menu6 *)

  _ClearScreen(_GViewPort);
  row := 12;
  col := 19;
  _SetTextColor(31);
  _SetTextPosition(row-9,col-11);
  _OutText('SET SOUND');
  _SetTextColor(30);
  _SetTextPosition(row-7,col-11);
  _OutText('DEFAULT = SOUND ON');
  _SetTextPosition(row-5,col-11);
  _OutText('Do you wish to have');
  _SetTextPosition(row-3,col-11);
  _OutText('sound ?       (Y/N)');
  _SetTextPosition(Row+5,Col-11);
  _OutText('HIT <ENTER> WHEN FINISHED');
  _SetTextPosition(row+7,col-11);
  _OutText('<ESC> = QUIT TO MAIN MENU');
  Box(Row,Col,LetterLength);
  i      := 0;
  length := 0;
  color  := $371e00;
  buffer := ' ';
  _SetTextColor(34);
  while (buffer <> ENTER) AND (buffer <> ESC) do
    begin
      FadeBox(color,i);
      buffer := ReadKey;
      _SetTextPosition(Row , Col + length);
      if (buffer <> ENTER) AND (buffer <> lf)
      then
	if (buffer = #0)
	then
	  begin
	    buffer := ReadKey;
	    if (buffer = Del) or (buffer = LeftArrow)
	    then
	      Delete(Row,Col,length);
	  end (* if *)
	else
	  begin
	    if (buffer = BS) or (buffer = CtrBS)
	    then
	      Delete(Row,Col,length)
	    else
	      begin
		if (buffer IN Menu6Set)
		then
		  begin
		    if length <> LetterLength
		    then
		      length := length + 1;
		    NameTemp[length] := buffer;
		    if length <> 0
		    then
		      _SetTextPosition(Row , Col + length - 1);
		    _OutText(buffer);
		  end (* if *)
		else
		  _SetTextPosition(Row , Col + length - 1);
	      end (* else *)
	  end (* else *)
      else
	if (length = 0)
	then
	  buffer := ' ';
    end; (* while *)
  Name := '';
  if (buffer <> ESC)
  then
    Case NameTemp[1] of
	    'y','Y' : Snd := true;
	    'n','N' : Snd := false;
    End; (* Case *)
  _SetTextColor(15);
  SetPage;

End;  (* Menu6 *)

Procedure Menu7(var Scrolling,Fast : boolean);

Const
  LetterLength = 1;

Type
  NameType     = array[1..40] of char;

Var
  NameTemp     : NameType;
  color        : Longint;
  Col , Row ,
  i , length   : integer;
  buffer       : char;

Begin (* Menu7 *)

  _ClearScreen(_GViewPort);
  row := 12;
  col := 19;
  _SetTextColor(31);
  _SetTextPosition(row-9,col-11);
  _OutText('SET DISPLAY TYPE');
  _SetTextColor(30);
  _SetTextPosition(row-7,col-11);
  _OutText('DEFAULT = SIMPLE DISPLAY');
  _SetTextPosition(row-5,col-11);
  _OutText('Do you wish to have the');
  _SetTextPosition(row-3,col-11);
  _OutText('display scrolling ?  (Y/N)');
  _SetTextPosition(Row+5,Col-11);
  _OutText('HIT <ENTER> WHEN FINISHED');
  _SetTextPosition(row+7,col-11);
  _OutText('<ESC> = QUIT TO MAIN MENU');
  Box(Row,Col,LetterLength);
  i      := 0;
  length := 0;
  color  := $371e00;
  buffer := ' ';
  _SetTextColor(34);
  while (buffer <> ENTER) AND (buffer <> ESC) do
    begin
      FadeBox(color,i);
      buffer := ReadKey;
      _SetTextPosition(Row , Col + length);
      if (buffer <> ENTER) AND (buffer <> lf)
      then
	if (buffer = #0)
	then
	  begin
	    buffer := ReadKey;
	    if (buffer = Del) or (buffer = LeftArrow)
	    then
	      Delete(Row,Col,length);
	  end (* if *)
	else
	  begin
	    if (buffer = BS) or (buffer = CtrBS)
	    then
	      Delete(Row,Col,length)
	    else
	      begin
		if (buffer IN Menu6Set)
		then
		  begin
		    if length <> LetterLength
		    then
		      length := length + 1;
		    NameTemp[length] := buffer;
		    if length <> 0
		    then
		      _SetTextPosition(Row , Col + length - 1);
		    _OutText(buffer);
		  end (* if *)
		else
		  _SetTextPosition(Row , Col + length - 1);
	      end (* else *)
	  end (* else *)
      else
	if (length = 0)
	then
	  buffer := ' ';
    end; (* while *)
  Name := '';
  if (buffer <> ESC)
  then
    Case NameTemp[1] of
	    'y','Y' : Begin
			Scrolling := true;
			Menu7b(Fast);
		      End;
	    'n','N' : Scrolling := false;
    End; (* Case *)
  _SetTextColor(15);
  SetPage;

End;  (* Menu7 *)

Procedure Menu1(Name : CString;
		NumSims : integer;
		var Credit : integer;
		var NumOfBets : integer;
		var Scrolling , Snd , Fast : boolean);

Var
  buffer : char;

Begin (* Menu1 *)

  SetPage;
  buffer := ' ';
  While (buffer <> ESC) and (CurSim <= NumSims) do
    begin
      buffer := ReadKey;
      if (ord(buffer) = 0)
      then
	begin
	  buffer := ReadKey;
	end (* if *)
      else
	if buffer in Menu1Set
	then
	  Case buffer of
	    '1' : Begin
		    _ClearScreen(_GViewPort);
		    FormatText(NumSims,CurSim,Credit,Name,BetNum);
		    Random_Wheels(Name,NumSims,Credit,NumOfBets,
				  BetNum,Scrolling,Snd,Fast);
		    if (CurSim <= NumSims)
		    then
		      SetPage
		    else
		      begin
			_ClearScreen(_GViewPort);
			_SetTextPosition(1,1);
			_OutText('Simulation Over');
			Delay(500);
		      end; (* else *)
		  End;
	    '2' : Menu2(Credit);

	    '3' : Menu3(NumOfBets);

	    '4' : Menu4(NumSims,Credit,NumOfBets,Scrolling,Snd,Fast);

	    '5' : Menu5;

	    '6' : Menu6(Snd);

	    '7' : Menu7(Scrolling,Fast);

	    '8' : buffer := ESC;
	  End; (* Case *)
    end; (* while *)

End;  (* Menu1 *)

Procedure FreeGraphics(var BarImage,CherryImage,PlumImage,
			   OrangeImage,BellImage : ImageType;
		       var BarSize,CherrySize,PlumSize,
			   OrangeSize,BellSize   : Word;
		       var SplitBar,SplitCherry,SplitPlum,
			   SplitOrange,SplitBell : SplitType);
Var
  count : integer;

Begin (* FreeGraphics *)

  For count := 1 to 31 do
    Begin
      FreeMem(SplitBar.Line[count],SplitBar.LineSize[count]);
      FreeMem(SplitCherry.Line[count],SplitCherry.LineSize[count]);
      FreeMem(SplitOrange.Line[count],SplitOrange.LineSize[count]);
      FreeMem(SplitBell.Line[count],SplitBell.LineSize[count]);
      FreeMem(SplitPlum.Line[count],SplitPlum.LineSize[count]);
    End; (* For *)
  FreeMem(BarImage,BarSize);
  FreeMem(CherryImage,CherrySize);
  FreeMem(PlumImage,PlumSize);
  FreeMem(OrangeImage,OrangeSize);
  FreeMem(BellImage,BellSize);

End;  (* FreeGraphics *)

Procedure SetDefaults(var NumSims,CurSim,Credit,NumOfBets : integer;
		      var Scrolling,Snd,Fast : boolean);

Begin (* SetDefaults *)

  NumSims   := 2;
  CurSim    := 1;
  Credit    := 50;
  NumOfBets := 100;
  BetNum    := 0;
  Scrolling := False;
  Snd       := true;
  Fast      := False;

End;  (* SetDefaults *)

BEGIN (* Main Program *)

  video := _SetVideoMode(_MRes256Color);
  _ClearScreen(_GViewPort);
  LoadGraphics(BarImage,CherryImage,PlumImage,OrangeImage,BellImage,
	       BarSize,CherrySize,PlumSize,OrangeSize,BellSize,
	       SplitBar,SplitCherry,SplitPlum,SplitOrange,SplitBell);
  SetDefaults(NumSims,CurSim,Credit,NumOfBets,Scrolling,Snd,Fast);
  Get_Users_Name(Name);
  Get_NumSims(NumSims);
  Menu1(Name,NumSims,Credit,NumOfBets,Scrolling,Snd,Fast);
  FreeGraphics(BarImage,CherryImage,PlumImage,OrangeImage,BellImage,
	       BarSize,CherrySize,PlumSize,OrangeSize,BellSize,
	       SplitBar,SplitCherry,SplitPlum,SplitOrange,SplitBell);
  video := _SetVideoMode(_DefaultMode);

END.  (* Main Program *)
