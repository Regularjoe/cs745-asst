; ModuleID = 'strength-m2r.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: nounwind
define i32 @compute(i32 %a, i32 %b) #0 {
entry:
  %mul = mul nsw i32 %a, 2
  %add = add nsw i32 0, %mul
  %mul1 = mul nsw i32 %a, 3
  %add2 = add nsw i32 %add, %mul1
  %mul3 = mul nsw i32 %a, 8
  %add4 = add nsw i32 %add2, %mul3
  %div = sdiv i32 %b, 2
  %sub = sub nsw i32 %add4, %div
  %div5 = sdiv i32 %b, 4
  %sub6 = sub nsw i32 %sub, %div5
  %div7 = sdiv i32 %b, 8
  %sub8 = sub nsw i32 %sub6, %div7
  ret i32 %sub8
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
