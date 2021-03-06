; ModuleID = 'out.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: nounwind
define i64 @fib(i32 %n) #0 {
entry:
  %cmp = icmp sle i32 %n, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %shl = shl i32 %n, 1
  %sub = sub nsw i32 %shl, %n
  %conv = sext i32 %sub to i64
  br label %return

if.end:                                           ; preds = %entry
  %sub1 = sub nsw i32 %n, 2
  %call = call i64 @fib(i32 %sub1)
  %sub2 = sub nsw i32 %n, 1
  %call3 = call i64 @fib(i32 %sub2)
  %add = add nsw i64 %call, %call3
  br label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi i64 [ %conv, %if.then ], [ %add, %if.end ]
  ret i64 %retval.0
}

; Function Attrs: nounwind
define i32 @magicTrick(i32 %n) #0 {
entry:
  %call = call i64 @fib(i32 5)
  %conv = trunc i64 %call to i32
  %shl = shl i32 %conv, 3
  %add4 = add nsw i32 %shl, 2
  ret i32 %add4
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
