#!/bin/bash
echo $(sensors | grep 'Processor Fan' | sed 's/ //g' | sed 's/ProcessorFan\://')

