--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 19.12.2014 - Time: 01:56
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDatabase = {}

function CDatabase:constructor(sHost, sUser, sPass, sDBName, nPort)
    self.sHost = sHost
    self.sUser = sUser
    self.sDBName = sDBName
    self.hCon = dbConnect("mysql", ("dbname=%s;host=%s;port=%s"):format(sDBName, sHost, nPort), sUser, sPass, "autoreconnect=1")
    if self.hCon then
        debugOutput(("[%s] Successfully connected!"):format(sDBName))
    else
        debugOutput(("[%s] Can't connect to mysql server!"):format(sDBName))
        stopResource(getThisResource())
    end
end

function CDatabase:destructor()
    self.sHost = nil
    self.sUser = nil
    self.sDBName = nil
    destroyElement(self.hCon)
end

function CDatabase:query(q, ...)
    local query = dbQuery(self.hCon, q, ...)
    local result, qRows, qliID = dbPoll(query, 100)
    if result == false then
        return false
    elseif result then
        return result, qRows, qliID
    else dbFree(query) end
end

function CDatabase:insert(t, c, v, ...)         --t = table | c = columns | v = values
    return dbExec(self.hCon, ("INSERT INTO %s (%s) VALUES (%s)"):format(t, c, v), ...)
end

function CDatabase:set(t, c, cV, w, wV)   		--t = table | c = column | cV = columnValue | w = where | wV = whereValue
    return dbExec(self.hCon, "UPDATE ?? SET ??=? WHERE ??=?", t, c, cV, w, wV)
end

function CDatabase:get(t, c, w, wV, wO, wVO)    --t = table | c = column | w = where | wV = whereValue | wO = whereOpational | wVO = whereValueOptional
    local q, rs
    if wO and wVO then q, rs = self:query(("SELECT %s FROM %s WHERE %s = '%s' AND %s = '%s'"):format(c, t, w, wV, wO, wVO)) elseif w and wV then q, rs = self:query(("SELECT %s FROM %s WHERE %s = '%s'"):format(c, t, w, wV)) else q, rs = self:query(("SELECT %s FROM %s"):format(c, t)) end
    if not q then return false end
    if rs > 1 then return q end

    for _, row in ipairs(q) do
        return row[c]
    end
end