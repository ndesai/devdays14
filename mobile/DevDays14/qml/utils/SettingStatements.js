.pragma library

var tableSettings = "settings"
var createSettingsTable = "CREATE TABLE IF NOT EXISTS %0(key TEXT, value TEXT)"
.replace("%0", tableSettings);


function insertSettingStatement(settingKey, settingValue)
{
    return "INSERT INTO %0 (key,value) VALUES('%1','%2')"
    .replace(/%0/g, tableSettings)
    .replace(/%1/g, settingKey)
    .replace(/%2/g, settingValue)
}

function getSettingStatement(settingKey)
{
    return "SELECT rowid, key, value FROM %0 WHERE key='%1' ORDER BY rowid DESC"
    .replace(/%0/g, tableSettings)
    .replace(/%1/g, settingKey)
}

function removeSettingStatement(settingKey)
{
    return "DELETE FROM %0 WHERE key = '%1'"
    .replace(/%0/g, tableSettings)
    .replace(/%1/g, settingKey)
}
