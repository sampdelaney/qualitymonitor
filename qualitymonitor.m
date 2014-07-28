classdef qualitymonitor < handle
    
    properties
       Files 
    end
    
    properties(Access=private)
        
    end
    
    methods
        function self = qualitymonitor(varargin)
            q.refreshTimer = timer('TimerFcn', @refreshTimerOnElapse,...
                'Period', 5, 'ExecutionMode', 'fixedRate');
            start(q.refreshTimer);
        end
        
        
        
        function refreshTimerOnElapse(timerObj, timerEvent)
            disp('bang');
        end
        
        
        function buildFileList(self)
            % empty file list
            self.Files = self.exploreDirectory(pwd());
        end
        
        function files = exploreDirectory(self, pathString)
            files = dir(fullfile(pathString, '*.m'));
            
            for iFile = 1 : length(files)
               files(iFile).name = fullfile(pathString,...
                   files(iFile).name);
            end
            
            % recurse to sub-directories
            directories = dir(fullfile(pathString, '*.'));
            [~, iValidDirectories] = setdiff({directories.name}, {'.', '..'});
            
            if isempty(iValidDirectories)
               return; 
            end
            
            for iDirectory = iValidDirectories
               directoryFiles = self.exploreDirectory(fullfile(pathString, ...
                   directories(iDirectory).name));
               files = [files directoryFiles];
            end
        end
    end
end