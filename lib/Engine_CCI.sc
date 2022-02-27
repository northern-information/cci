// by @infinitedigits

// Engine_CCI

// Inherit methods from CroneEngine
Engine_CCI : CroneEngine {

  // <CCI> 
  var bufCCI;
  var synCCI;
  // </CCI>

  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }

  alloc {
    // <CCI> 
    bufCCI=Dictionary.new(128);
    synCCI=Dictionary.new(128);

    context.server.sync;

    SynthDef("playerCCIStereo",{ 
        arg bufnum, amp=0, ampLag=0, t_trig=0,
        sampleStart=0,sampleEnd=1,loop=0,
        rate=1;

        var snd;
        var frames = BufFrames.kr(bufnum);

        // lag the amp for doing fade out
        amp = Lag.kr(amp,ampLag);
        // use envelope for doing fade in
        amp = amp * EnvGen.ar(Env([0,1],[ampLag]));
        
        // playbuf
        snd = PlayBuf.ar(
          numChannels:2, 
          bufnum:bufnum,
          rate:BufRateScale.kr(bufnum)*rate,
          startPos: ((sampleEnd*(rate<0))*(frames-10))+(sampleStart*frames*(rate>0)),
          trigger:t_trig,
          loop:loop,
          doneAction:2,
        );

        // multiple by amp and attenuate
        snd = snd * amp / 20 ;

        // if looping, free up synth if no output
        DetectSilence.ar(snd,doneAction:2);

        Out.ar(0,snd)
    }).add; 

    SynthDef("playerCCIMono",{ 
        arg bufnum, amp=0, ampLag=0, t_trig=0,
        sampleStart=0,sampleEnd=1,loop=0,
        rate=1;

        var snd;
        var frames = BufFrames.kr(bufnum);

        // lag the amp for doing fade in/out
        amp = Lag.kr(amp,ampLag);
        // use envelope for doing fade in
        amp = amp * EnvGen.ar(Env([0,1],[ampLag]));
        
        // playbuf
        snd = PlayBuf.ar(
          numChannels:1, 
          bufnum:bufnum,
          rate:BufRateScale.kr(bufnum)*rate,
          startPos: ((sampleEnd*(rate<0))*(frames-10))+(sampleStart*frames*(rate>0)),
          trigger:t_trig,
          loop:loop,
          doneAction:2,
        );

        snd = Pan2.ar(snd,0);

        // multiple by amp and attenuate
        snd = snd * amp / 20;

        // if looping, free up synth if no output
        DetectSilence.ar(snd,doneAction:2);

        Out.ar(0,snd)
    }).add; 


    this.addCommand("play","sfffffff", { arg msg;
      var filename=msg[1];
      var synName="playerCCIMono";
      if (bufCCI.at(filename)==nil,{
        // load buffer
        Buffer.read(context.server,filename,action:{
          arg bufnum;
          if (bufnum.numChannels>1,{
            synName="playerCCIStereo";
          });
          bufCCI.put(filename,bufnum);
          synCCI.put(filename,Synth(synName,[
            \bufnum,bufnum,
            \amp,msg[2],
            \ampLag,msg[3],
            \sampleStart,msg[4],
            \sampleEnd,msg[5],
            \loop,msg[6],
            \rate,msg[7],
            \t_trig,msg[8],
          ],target:context.server).onFree({
            // ("freed "++filename).postln;
          }));
          NodeWatcher.register(synCCI.at(filename));
        });
      },{
        // buffer already loaded, just play it
        if (bufCCI.at(filename).numChannels>1,{
          synName="playerCCIStereo";
        });
        if (synCCI.at(filename).isRunning==true,{
          synCCI.at(filename).set(
            \bufnum,bufCCI.at(filename),
            \amp,msg[2],
            \ampLag,msg[3],
            \sampleStart,msg[4],
            \sampleEnd,msg[5],
            \loop,msg[6],
            \rate,msg[7],
            \t_trig,msg[8],
          );
        },{
          synCCI.put(filename,Synth(synName,[
            \bufnum,bufCCI.at(filename),
            \amp,msg[2],
            \ampLag,msg[3],
            \sampleStart,msg[4],
            \sampleEnd,msg[5],
            \loop,msg[6],
            \rate,msg[7],
            \t_trig,msg[8],
          ],target:context.server).onFree({
            // ("freed "++filename).postln;
          }));
          NodeWatcher.register(synCCI.at(filename));
        });
      });
    });
    // </CCI> 

  }

  free {
    // <CCI> 
    synCCI.keysValuesDo({ arg key, value; value.free; });
    bufCCI.keysValuesDo({ arg key, value; value.free; });
    // </CCI> 
  }
}