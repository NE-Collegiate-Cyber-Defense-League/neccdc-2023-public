#!/usr/bin/env python3

from flask import Flask, render_template, request, jsonify, make_response
from webargs import fields
from webargs.flaskparser import use_args
import subprocess
from logging.config import dictConfig

app = Flask(__name__)

team = subprocess.run(["hostname", "-I"], stdout=subprocess.PIPE).stdout.decode().strip().split('.')[2]
hosts = {
        "ca"       : '10.0.1.32',
        "dc"       : '10.0.1.16',
        "ws1"      : '10.0.2.48',
        "jenkins"  : '10.0.3.64',
        "wazuh"    : '10.0.3.128',
        "manager"  : '10.0.4.64',
        "worker1"  : '10.0.5.64',
        "worker2"  : '10.0.6.64',
        "worker3"  : '10.0.7.64',
        "proxy"    : f'10.1.{team}.16',
        "teleport" : f'10.1.{team}.32',
        "tea"      : f'10.1.{team}.64',
    }
@app.route('/')
def hello():
    return "Black Team use only"

@app.route('/icmp', methods=['GET'])
@use_args({
    "host": fields.String(),
    }, location='query')
def icmp(args):
    try:
        subprocess.run(["ping", "-c1", "-W3", hosts[args['host']]], check=True)
        return make_response("True", 200)
    except Exception as e:
        print(e)
        return make_response("False", 200)

if __name__ == "__main__":
    app.run(host='0.0.0.0')