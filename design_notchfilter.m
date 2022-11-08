% notchfilter design
    d = designfilt('bandstopfir','FilterOrder',5000, ...
         'CutoffFrequency1',49,'CutoffFrequency2',51, ...
         'SampleRate',1000);
   
    % filter visualisation
    fvtool(d); 
  
    % save the filter
    save('notchfilter50Hz','d');
