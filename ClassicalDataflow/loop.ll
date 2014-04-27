; ModuleID = 'loop.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

; Function Attrs: nounwind readnone
define i32 @sum(i32 %a, i32 %b) #0 {
entry:
  %cmp4 = icmp sgt i32 %b, %a
  br i1 %cmp4, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %0 = sub i32 %b, %a
  %n.vec = and i32 %0, -8
  %end.idx.rnd.down = add i32 %n.vec, %a
  %cmp.zero = icmp eq i32 %n.vec, 0
  br i1 %cmp.zero, label %middle.block, label %vector.body

vector.body:                                      ; preds = %vector.body, %for.body.preheader
  %index = phi i32 [ %index.next, %vector.body ], [ %a, %for.body.preheader ]
  %vec.phi = phi <4 x i32> [ %1, %vector.body ], [ <i32 1, i32 1, i32 1, i32 1>, %for.body.preheader ]
  %vec.phi7 = phi <4 x i32> [ %2, %vector.body ], [ <i32 1, i32 1, i32 1, i32 1>, %for.body.preheader ]
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %index, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %induction = add <4 x i32> %broadcast.splat, <i32 0, i32 1, i32 2, i32 3>
  %induction8 = add <4 x i32> %broadcast.splat, <i32 4, i32 5, i32 6, i32 7>
  %1 = mul nsw <4 x i32> %vec.phi, %induction
  %2 = mul nsw <4 x i32> %vec.phi7, %induction8
  %index.next = add i32 %index, 8
  %3 = icmp eq i32 %index.next, %end.idx.rnd.down
  br i1 %3, label %middle.block, label %vector.body, !llvm.loop !1

middle.block:                                     ; preds = %vector.body, %for.body.preheader
  %resume.val = phi i32 [ %a, %for.body.preheader ], [ %end.idx.rnd.down, %vector.body ]
  %rdx.vec.exit.phi = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %for.body.preheader ], [ %1, %vector.body ]
  %rdx.vec.exit.phi11 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %for.body.preheader ], [ %2, %vector.body ]
  %bin.rdx = mul <4 x i32> %rdx.vec.exit.phi11, %rdx.vec.exit.phi
  %rdx.shuf = shufflevector <4 x i32> %bin.rdx, <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx12 = mul <4 x i32> %bin.rdx, %rdx.shuf
  %rdx.shuf13 = shufflevector <4 x i32> %bin.rdx12, <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx14 = mul <4 x i32> %bin.rdx12, %rdx.shuf13
  %4 = extractelement <4 x i32> %bin.rdx14, i32 0
  %cmp.n = icmp eq i32 %resume.val, %b
  br i1 %cmp.n, label %for.end, label %for.body

for.body:                                         ; preds = %for.body, %middle.block
  %res.06 = phi i32 [ %mul, %for.body ], [ %4, %middle.block ]
  %i.05 = phi i32 [ %inc, %for.body ], [ %resume.val, %middle.block ]
  %mul = mul nsw i32 %res.06, %i.05
  %inc = add nsw i32 %i.05, 1
  %exitcond = icmp eq i32 %inc, %b
  br i1 %exitcond, label %for.end, label %for.body, !llvm.loop !4

for.end:                                          ; preds = %for.body, %middle.block, %entry
  %res.0.lcssa = phi i32 [ 1, %entry ], [ %mul, %for.body ], [ %4, %middle.block ]
  ret i32 %res.0.lcssa
}

attributes #0 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
!1 = metadata !{metadata !1, metadata !2, metadata !3}
!2 = metadata !{metadata !"llvm.vectorizer.width", i32 1}
!3 = metadata !{metadata !"llvm.vectorizer.unroll", i32 1}
!4 = metadata !{metadata !4, metadata !2, metadata !3}
