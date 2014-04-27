; ModuleID = 'loop-m2r.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@g = common global i32 0, align 4

; Function Attrs: nounwind
define i32 @g_incr(i32 %c) #0 {
entry:
  %0 = load i32* @g, align 4
  %add = add nsw i32 %0, %c
  store i32 %add, i32* @g, align 4
  %1 = load i32* @g, align 4
  ret i32 %1
}

; Function Attrs: nounwind
define i32 @loop(i32 %a, i32 %b, i32 %c) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ %a, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %b
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call = call i32 @g_incr(i32 %c)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %0 = load i32* @g, align 4
  %add = add nsw i32 0, %0
  ret i32 %add
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
