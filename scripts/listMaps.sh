#!/usr/bin/env node

// This is an example of how to call a node module from the command line,
const getMapList = require('../node/getMapList.js');
const mapDir = process.env.HOME + '/.arlobot/rosmaps/';
const formatOutput = function(err, data) {
    data.forEach(function(value) {
        console.log(value.replace('.yaml', ''));
    });
};
getMapList(mapDir, formatOutput);
