set compile_env: 2

category: 'instance creation'
classmethod: Delay
forMilliseconds: aNumber
	<PharoGs>
	^self @env0:forMilliseconds: aNumber
%

category: 'instance creation'
classmethod: Delay
forSeconds: aNumber
	<PharoGs>
	^self @env0:forSeconds: aNumber
%

category: 'delaying'
method: Delay
wait
	<PharoGs>
	self @env0:wait
%

set compile_env: 0
