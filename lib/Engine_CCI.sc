// by @infinitedigits

// Engine_CCI

// Inherit methods from CroneEngine
Engine_CCI : CroneEngine {

  // <CCI> 
  var cciSample;
  // </CCI>

  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }

  alloc {
    // <CCI> 
    cciSample=CCISample(context.server,0);

    this.addCommand("sample_play","sff", { arg msg;
      var filename=msg[1];
      var fade=msg[2];
      var loop=msg[3];
      cciSample.play(filename,fade,loop);
    });

    this.addCommand("sample_stop","sf", { arg msg;
      var filename=msg[1];
      var fade=msg[2];
      cciSample.stop(filename,fade);
    });

    this.addCommand("sample_set","ssf", { arg msg;
      var filename=msg[1];
      var key=msg[2];
      var value=msg[3];
      cciSample.set(filename,key,value);
    });
    // </CCI> 

  }

  free {
    // <CCI> 
    cciSample.free;
    // </CCI> 
  }
}