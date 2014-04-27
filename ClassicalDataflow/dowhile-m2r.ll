; ModuleID = 'dowhile-m2r.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: nounwind
define i32 @sum(i32 %a, i32 %b) #0 {
entry:
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  %x.0 = phi i32 [ 0, %entry ], [ %add2, %do.cond ]
  %add = add nsw i32 %a, %b
  %add1 = add nsw i32 %x.0, -2
  %add2 = add nsw i32 %add1, %add
  %cmp = icmp slt i32 %add2, 0
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %do.body
  %cmp3 = icmp slt i32 -2, 8
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %do.body
  %inc = add nsw i32 -2, 1
  br label %if.end

if.end:                                           ; preds = %if.then, %lor.lhs.false
  br label %do.cond

do.cond:                                          ; preds = %if.end
  %cmp4 = icmp slt i32 %add2, 42
  br i1 %cmp4, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  ret i32 %add2
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
