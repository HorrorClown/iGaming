--ToDo: Script informations..

CDownloadManager = {}

function CDownloadManager:constructor()
  self.Files = {}
  self.ableToLoad = false
  
  self:getFiles()
  self:loadFiles()
end

function CDownloadManager:destructor()

end

function CDownloadManager:getFiles()
  local xmlFile = XML.load("shared/files.xml")
  if not xmlFile then debugOutput("[CDownloadManager] Error while loading xml") return end
  local fileDirs = xmlFile:getChildren()
  
  for _, dir in ipairs(fileDirs) do
    local dirName = dir:getName()
    local dirFiles = dir:getChildren()
    
    for _, dirFile in ipairs(dirFiles) do
      local fileInfo = dirFile:getAttributes()
      local filePath = ("files/%s/%s"):format(dirName, fileInfo.src)
      
      if fileExists(filePath) then
        table.insert(self.Files, {src = filePath, info = fileInfo})
      else
        debugOutput(("[CDownloadManager] Can't find file '%s'"):format(filePath))
      end
    end
  end
  
  self.ableToLoad = true
  xmlFile:close()
end

function CDownloadManager:loadFiles()
  if not self.ableToLoad then return end
end
