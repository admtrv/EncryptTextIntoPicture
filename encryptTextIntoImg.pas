uses School;
uses GraphABC;

{$reference 'System.Drawing.dll'}
{Enter the name of the image file in the Create( ) window}
var
  bitmap := System.Drawing.Bitmap.Create('image.jpg');

begin
  {Enter the name of the text file in the ReadAllText( ) window}
  var s := ReadAllText('string.txt') + '~';
  
  var (width, height) := (bitmap.Width, bitmap.Height);
  SetWindowSize(width, height);
  SetWindowIsFixedSize(true);
  
  var u := 1;
  for var j := 0 to height - 1 do
    for var i := 0 to width - 1 do 
    begin
      var colour := bitmap.GetPixel(i, j);
      var (red, green, blue) := (ToBase(colour.R.ToString, 2), ToBase(colour.g.ToString, 2), ToBase(colour.b.ToString, 2));
      red := (8 - red.Length) * '0' + red;
      green := (8 - green.Length) * '0' + green;
      blue := (8 - blue.Length) * '0' + blue;
      
      if u <= s.Length then
      begin
        var letter := ToBase(ord(s[u]).ToString, 2);
        letter := (8 - letter.Length) * '0' + letter;
        
        red[6:9] := letter[1:4];
        green[7:9] := letter[4:6];
        blue[6:9] := letter[6:9];
        
        u += 1;
      end;
      
      SetPixel(i, j, color.FromArgb(Dec(red, 2), Dec(green, 2), Dec(blue, 2)));
    end;
  
  SaveWindow('imgWithEncryptedText.bmp');
end.