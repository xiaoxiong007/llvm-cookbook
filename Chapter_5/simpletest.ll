declare void @nounwind() nounwind

define internal void @foo() {
  call void @nounwind()
  ret void
}

define i32 @caller() {
  invoke void @foo( )
    		to label %Normal unwind label %Except

Normal:    	; preds = %0
  ret i32 0

Except:    	; preds = %0
  landingpad { i8*, i32 } personality i32 (...)* @__gxx_personality_v0
                catch i8* null
  ret i32 1
}

declare i32 @__gxx_personality_v0(...)
