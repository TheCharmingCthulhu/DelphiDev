unit IntelligentAI;

// class = Static or Type Object Creation. :P

interface

uses
  StringExtensions, SysUtils, StrUtils, Classes, WinAPIWrapper, Vcl.Graphics;

const
  // Command list.
  TArtificialCommands: array[0..5] of string = ('debug', 'run', 'exit',
   'screenshot', 'search', 'terminal');

type
  // Artificial Result State Enum.
  TArtificialState = (NONE, SUCCESS, ERROR, MISSING_ARGUMENTS);

  // Result on command call.
  TArtificialResult = class
      Code: TArtificialState;
      Value: string;
      constructor Create;
  end;

  // Terminal Class
  TArtificialTerminal = class
    private
      class procedure Debug(const args: TStringList;
        aiResult: TArtificialResult);
    public
      // -- Takes a command and arguments and executes the specific function...
      class procedure Command(const cmd: string; const args: TStringList;
       aiResult: TArtificialResult);
      // -- Run's a application or opens a folder on the provided path
      // with the respective arguments...
      class procedure Run(const path: string; const args: TStringList;
        aiResult: TArtificialResult);
      // -- Hides the Terminal, takes a screenshot, shows the Terminal, prints
      // the screenshot filename.
      class procedure Screenshot(aiResult: TArtificialResult);
      // -- Searches a specific directory with the provided searchPattern
      // on the specified path.
      class procedure Search(path:string; const searchPattern:string;
       aiResult:TArtificialResult);
      // -- Executes some Terminal System commands or options.
      class procedure System(const args: TStringList;
       aiResult: TArtificialResult);
  end;

  { -- Delegates -- }
  TArtificialProcedure = procedure of object;

implementation
uses
  Terminal, ShellApi, Winapi.Windows;

constructor TArtificialResult.Create;
begin
  self.Code := TArtificialState.NONE;
  self.Value := '';
end;

class procedure TArtificialTerminal.Command(const cmd: string;
  const args: TStringList;
  aiResult: TArtificialResult);
begin
  case StringCase(cmd, TArtificialCommands) of
     1: Debug(args, aiResult);
     2:
       begin
          Run(args[0], args, aiResult);
       end;
     3: Terminal.Main.Close(); // Closes the application.
     4: Screenshot(aiResult);
     5:
       begin
         if args.Count = 2 then
         begin
           Search(args[0], args[1], aiResult);
         end else if args.Count = 1 then
         begin
           Search(args[0], '*', aiResult);
         end;
       end;
     6: System(args, aiResult);
  else
    aiResult.Code := TArtificialState.ERROR;
    aiResult.Value := 'Command "' + cmd + '" does not exist.';
  end;
end;

class procedure TArtificialTerminal.Debug(const args: TStringList;
  aiResult: TArtificialResult);
begin
  if(args.Count > 1) then
  begin
    // Prints out a line of provided arguments, cuts of the CRLF feed.
    AIResult.Code := TArtificialState.SUCCESS;
    AIResult.Value := 'debug:' + args.Text.Substring(0, args.Text.Length - 2);
  end else
  begin
    AIResult.Code := TArtificialState.MISSING_ARGUMENTS;
  end;
end;

class procedure TArtificialTerminal.Run(const path: string;
 const args: TStringList; aiResult: TArtificialResult);
var
  arguments: string;
begin
  // Delete the command from the args.
  if args.Count > 0 then
  begin
    args.Delete(0);
  end;

  arguments := StringReplace(args.Text, #13#10, ' ', [SysUtils.rfReplaceAll]);

  aiResult.Value := WinAPIWrapper.RunApplication(path, arguments);

  if aiResult.Value = '' then
  begin
    aiResult.Code := TArtificialState.SUCCESS;
    aiResult.Value := 'Process Running:"' + path +
     '" with arguments -> "' + arguments + '"';
  end else
  begin
    aiResult.Code := TArtificialState.ERROR;
    aiResult.Value.Replace('file', 'directory');
  end;
end;

class procedure TArtificialTerminal.Screenshot(aiResult: TArtificialResult);
var
  deskHDC: Winapi.Windows.HDC;
  deskRes: WinAPIWrapper.TResolutionInfo;
  screenshot: Vcl.Graphics.TBitmap;
  screenshotsDir: string;
  screenDate: string;
  dateFormat, timeFormat: string;
begin
  Terminal.TerminalHide();
  Terminal.Main.AIFunctionMode := True;

  // Hide terminal first.
  while Terminal.Main.Hidden = False do
  begin
  end;

  try
    // Set screenshots folder.
    screenshotsDir := GetCurrentDir + '/Screenshots';

    // Create display device to take a screenshot.
    deskHDC := Winapi.Windows.CreateDC('Display', nil, nil, nil);
    WinAPIWrapper.GetDesktopResolution(deskRes);

    screenshot := Vcl.Graphics.TBitmap.Create;
    screenshot.PixelFormat := TPixelFormat.pfDevice;
    screenshot.Width := deskRes.Width;
    screenshot.Height := deskRes.Height;

    if not DirectoryExists(screenshotsDir) then
    begin
      CreateDir(screenshotsDir);
    end;

    // Take screenshot.
    Winapi.Windows.BitBlt(screenshot.Canvas.Handle, 0, 0,
     deskRes.Width, deskRes.Height, deskHDC, 0, 0, Winapi.Windows.SRCCOPY);

    dateFormat := 'dd.mm.yyyy';
    timeFormat := 'hh-nn-ss';

    screenDate := FormatDateTime(dateFormat, Date) + '-' +
      FormatDateTime(timeFormat, Time);
    screenshot.SaveToFile(screenshotsDir + '\' + screenDate + '.png');

    aiResult.Code := TArtificialState.SUCCESS;
    aiResult.Value := 'Screenshot:' + screenDate + ' has been created.';
  finally
    FreeAndNil(screenshot);
    FreeAndNil(deskRes);
    Winapi.Windows.DeleteDC(deskHDC);
  end;

  Terminal.TerminalShow;
end;

class procedure TArtificialTerminal.Search(path:string;
 const searchPattern: string; aiResult: TArtificialResult);
var
  fileRecord: SysUtils.TSearchRec;
  fileCount: integer;
  fileHandleResult: integer;
  dirCount: integer;
begin
  // Initialization
  fileCount := 0; dirCount := 0;

  // Start a fileSearch and returns a fileHandle(fileRecord);
  fileHandleResult := FindFirst(IncludeTrailingPathDelimiter(path) +
   searchPattern, SysUtils.faAnyFile and SysUtils.faDirectory, fileRecord);

  if fileHandleResult = 0 then
  begin
    Main.Console_WriteLine('-- [Path search started @ "'+ path +'"] --');

    if not (path[Length(path)] = '/') and not (path[Length(path)] = #92) then
    begin
      path := IncludeTrailingPathDelimiter(path);
    end;

    begin
      try
        // Search and prints until no files have been found.
        repeat
          if (fileRecord.Name <> '.') and (fileRecord.Name <> '..') then
            begin
            if fileRecord.Attr = SysUtils.faDirectory then
            begin
              Main.Console_WriteLine('[Folder]"' +
               path + fileRecord.Name + '"');
              Inc(dirCount);
            end else
            begin
              Main.Console_WriteLine('[File]"' +
               path + fileRecord.Name + '"');
              Inc(fileCount);
            end;
          end;
        until FindNext(fileRecord) <> 0;
      finally
        // Closes the search fileHandle.
        FindClose(fileRecord.FindHandle);
      end;
    end;
  end else
  begin
    aiResult.Code := TArtificialState.ERROR;
    aiResult.Value := 'Code - ' + fileHandleResult.ToString();
    exit;
  end;

  Main.Console_WriteLine('-- [Search Results] --');
  Main.Console_WriteLine(fileCount.ToString() + ' Files have been listed');
  Main.Console_WriteLine(dirCount.ToString() + ' Directories have been listed.');

  aiResult.Code := TArtificialState.SUCCESS;
  aiResult.Value := '-- [Search finished] --';
end;

class procedure TArtificialTerminal.System(const args: TStringList;
 aiResult: TArtificialResult);
var
  I: Integer;
  emptyArgs: TStringList;
  argIndex: Integer;
  cwd: string;
begin
  emptyArgs := TStringList.Create;
  cwd := ExtractFileDir(ParamStr(0));

  for I := 0 to args.Count - 1 do
  begin
    if StringExtensions.StrInList('-open', args) then
    begin

    end;
    if args[I] = '-dir' then
    begin
      search(cwd, '*', aiResult);
    end
  end;
end;

end.
