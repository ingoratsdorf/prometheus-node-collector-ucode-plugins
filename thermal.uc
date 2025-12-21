import * as fs from "fs";

const base_path = "/sys/class/thermal";
const directories = fs.lsdir(base_path);

if (!directories)
    return false;

for (let dir in directories) {
    if (!match(dir, /^thermal_zone[0-9]+$/))
        continue;

    // Mandatory
    let type_path = sprintf("%s/%s/type", base_path, dir);
    let temp_path = sprintf("%s/%s/temp", base_path, dir);

    let type_str = trim(fs.readfile(type_path));
    let temp_str = trim(fs.readfile(temp_path));

    if (!type_str || !temp_str)
        continue;


    // Optional attributes

    let mode_path = sprintf("%s/%s/mode", base_path, dir);
    let passive_path = sprintf("%s/%s/passive", base_path, dir);
    let policy_path = sprintf("%s/%s/policy", base_path, dir);

    let policy_str = fs.readfile(policy_path);
    if (policy_str)
       policy_str = trim(policy_str);
    else
       policy_str = "";

    let passive_str = fs.readfile(passive_path);
    if (passive_str)
       passive_str = trim(passive_str);
    else
       passive_str = "";

    let mode_str = fs.readfile(mode_path);
    if (mode_str)
       mode_str = trim(mode_str);
    else
       mode_str = "";

    let temp_c = int(temp_str) / 1000.0;

    gauge("node_thermal_zone_temp")({zone: dir, type: type_str, policy: policy_str, passive: passive_str, mode: mode_str}, temp_c);
    //printf("node_thermal_zone_temp{zone: %s, type: %s, policy: %s, passive: %s, mode: %s} %f", dir, type_str, policy_str, passive_str, mode_str, temp_c);

}
