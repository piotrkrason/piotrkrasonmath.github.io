function setiPhoneStuff()
{
	if( document.body )
	{
		var script = document.createElement("script");
		script.src = "scale.fix.js";
		document.body.appendChild(script);
	}
	else
	{
		setTimeout(setiPhoneStuff, 0);
	}
}

setTimeout(setiPhoneStuff, 0);



