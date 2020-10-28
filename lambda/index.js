'use strict';

const AWS = require('aws-sdk');

const publish = async (records, stream, kinesis) => {
    if(records.length == 0) return;
    console.log(`Publishing ${records.length} records to ${stream}`);
    await kinesis.putRecords({
        Records: records.map(r => ({ Data: Buffer.from(r.kinesis.data, 'base64'), PartitionKey: 'data' })),
        StreamName: stream
    }).promise();
}

const kinesisClient = async () => {
    let stsParams = {
        RoleArn: process.env.KINESIS_ASSUMED_ROLE,
        RoleSessionName: "assumedRoleSession"
    }
    let sts = new AWS.STS();
    let assumedRole = await sts.assumeRole(stsParams).promise();
    const crossAccountAccessParams = {
        accessKeyId: assumedRole.Credentials.AccessKeyId,
        secretAccessKey: assumedRole.Credentials.SecretAccessKey,
        sessionToken: assumedRole.Credentials.SessionToken
    };
    return new AWS.Kinesis(crossAccountAccessParams);
}

module.exports.handler = async (event) => {
    console.log(`Received ${event.Records.length} events`);
    const kinesis = await kinesisClient();
    try {
        const streams = process.env.STREAMS.split(',');
        for (var stream of streams) {
            await publish(event.Records, stream, kinesis);
        }
    } catch (err) {
        console.log(`Failed with the error ${err.message}`);
    }
};
