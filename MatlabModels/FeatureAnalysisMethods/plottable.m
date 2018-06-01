% PLOTTABLE   Plot vector or matrix as table.
%
%     PLOTTABLE(X) plots X as a table. The default printing format is
%     floating point with two decimal places.
%
%     PLOTTABLE(X,CONTROL) uses the string CONTROL as the printing control
%     string for printing the elements of X.  It should be of the format 
%     accepted by SPRINTF or simply be the word RATS to print elements as 
%     fractions.  RATS cannot currently be combined with any other control
%     string arguments and must appear simply as 'rats'.  CONTROL can be a 
%     vertical matrix of strings as created by the function STRVCAT in which 
%     case the control strings will be cycled through to print columns of the 
%     table.  If CONTROL is not specified, it defaults to '%.2f'.
%
%     PLOTTABLE(X,CONTROL,COLGROUP) uses the numbers in the vector COLGROUP 
%     to group columns together for printing.  The sum of the numbers in 
%     COLGROUP should not exceed the numbers of columns in X.  By default
%     all the elements in COLGROUP will equal 1.
%
%     Example
%          x = [ 'ABCDEF';'GHIJKL';'MNOPQR'];
%          control = strvcat('%s','$%c','*\n[%d]\n*');
%          colgroup = [2 1 2 1];
%
%          figure
%          subplot(2,2,1);
%          plottable(x);
%
%          subplot(2,2,2);
%          plottable(x,control);
%
%          subplot(2,2,3);
%          plottable(x,control,colgroup);
%
%          subplot(2,2,4);
%          plottable(x,control(2:3,:),colgroup(1:2));
%
%    Example using RATS
%
%          x = [ 0.5 .3333 .8888; 1.2 pi 0.625];
%          control = strvcat('rats', '%.4f');
%          figure
%          plottable(x,control);
%
%    See also RATS, TITLE, XLABEL, YLABEL, AXIS, SUBPLOT,
%    SPRINTF, IMTEXT, and STRVCAT.

%
%    Written by Edward Brian Welch (edwardbrianwelch@yahoo.com)
%    Mayo Graduate School, 02-04-1999
%

%
%    Added RATS capability, 04/25/2000, EBW
%
function[ht] = plottable(x,control,colgroup)

% GET SIZE OF X
[xrows, xcols] = size(x);

% IF NO CONTROL STRING, INITIALIZE IT
if nargin<2,
   control = '%.2f';
end

% FIND NUMBER OF CONTROL STRINGS
numcontrol = size(control,1);

% IF NO COLUMN GROUPING INITIALIZE IT
if nargin<3,
   colgroup = ones(xcols,1);
end

% FIND THE NUMBER OF COLUMN GROUPINGS 
% AND THE TOTAL NUMBER OF ELEMENTS IN A ROW
numcolgroup = length(colgroup);
sumcolgroup = sum(colgroup);

% SET NUMBER OF ROWS AND COLUMNS IN THE TABLE 
numrow = xrows;
numcol = numcolgroup * floor(xcols/sumcolgroup);

% IF COLGROUP DESCRIBES MORE ELEMENTS THAN X HAS RETURN AN ERROR
if numcol==0,
   error('Column Grouping Describes More Elements Than A Single Row Of The Input Matrix');
end

% INITIALIZE PLOT AREA
plot(0,0);
axis([0 numcol 0 numrow]);
set(gca,'XTick', (1:numcol) - 0.5);
set(gca, 'XAxisLocation', 'top')
set(gca,'YTick', (1:numrow) - 0.5);
set(gca,'XTickLabel', (1:numcol));
set(gca,'YTickLabel', (numrow:-1:1));

% DRAW LINES OF THE TABLE
lh = line( [0:numcol ; 0:numcol],[zeros(1,numcol+1) ; ones(1,numcol+1)*numrow]);
set(lh,'color','black');
lh = line( [zeros(1,numrow+1) ; ones(1,numrow+1)*numcol],[0:numrow ; 0:numrow]);
set(lh,'color','black');

% FILL IN ELEMENTS OF THE TABLE
for row=1:numrow,
   
   start_col = 1;
   stop_col  = 0;
   
   for col=1:numcol,
      
      % PICK CONTROL STRING TO USE
      con = mod( (col-1),numcontrol) + 1;
      
      % PICK NUMBER OF COLUMNS TO GROUP 
      % AND ADD TO THE COLUMN STOPPING POINT
      cg  = mod( (col-1),numcolgroup) + 1;
      stop_col = stop_col + colgroup(cg);
      
      % SET COLUMN LOCATIONS TO LOOK AT IN X
      columns = start_col:stop_col;
      
      % BUILD STRING TO PRINT
      if findstr(control(con,:),'rats'),
         s = rats(x(row,columns));
      else
         s = sprintf( control(con,:), x(row,columns) ); 
      end
      
      % PLACE STRING IN TABLE
      ht(row,col) = imtext( (col-0.5)/numcol, (1-(row-0.5)/numrow),  s);
      
      % UPDATE NEXT STARTING POSITION
      start_col = stop_col + 1;
      
    end
 end