; ModuleID = 'loop-m2r.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: nounwind readnone
define i32 @sum(i32 %a, i32 %b) #0 {
entry:
  %cmp4 = icmp slt i32 %a, %b
  br i1 %cmp4, label %for.body, label %for.end

for.body:                                         ; preds = %for.body, %entry
  %res.06 = phi i32 [ %mul, %for.body ], [ 1, %entry ]
  %i.05 = phi i32 [ %inc, %for.body ], [ %a, %entry ]
  %mul = mul nsw i32 %res.06, %i.05
  %inc = add nsw i32 %i.05, 1
  %exitcond = icmp eq i32 %inc, %b
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %res.0.lcssa = phi i32 [ 1, %entry ], [ %mul, %for.body ]
  ret i32 %res.0.lcssa
}

attributes #0 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
