import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nastya_diplom/domain/reg_ex.dart';

class BlocTextFieldInt<B extends BlocBase<S>, S> extends StatelessWidget {
  static final RegExInputFormatter _negativeLimitValidator =
      RegExInputFormatter.withRegex('^\$|^[0\\-]\$|^\\-\$|^\\-{0,1}[1-9][0-9]{0,9}?\$');
  static final RegExInputFormatter _limitValidator = RegExInputFormatter.withRegex('^\$|^0\$|^[1-9][0-9]{0,12}?\$');

  final B bloc;
  final int? Function(S) stateValue;
  final Function(int?) onChanged;
  final String? labelText;
  final String? hintText;
  final bool nullable;
  final bool negative;
  final InputDecoration? decoration;

  const BlocTextFieldInt({
    super.key,
    required this.bloc,
    required this.stateValue,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.nullable = false,
    this.negative = false,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return BlocTextField<B, S, int>(
      key: key,
      labelText: labelText,
      hintText: hintText,
      onChanged: onChanged,
      decoration: decoration,
      bloc: bloc,
      stateValue: stateValue,
      inputToValue: (String input) {
        final res = int.tryParse(input);
        return res ?? (nullable ? null : 0);
      },
      autocorrect: false,
      keyboardType: TextInputType.numberWithOptions(signed: negative),
      inputFormatters: negative ? [_negativeLimitValidator] : [_limitValidator],
    );
  }
}

class BlocTextFieldDouble<B extends BlocBase<S>, S> extends StatelessWidget {
  static final RegExInputFormatter _limitValidator = RegExInputFormatter.withRegex(
    '^\$|^(0?|([1-9][0-9]{0,9}))(\\.[0-9]{0,4})?\$',
  );

  static final RegExInputFormatter _negativeLimitValidator = RegExInputFormatter.withRegex(
    '^\$|^[0\\-]\$|^\\-?(0?|([1-9][0-9]{0,9}))(\\.[0-9]{0,4})?\$',
  );

  final String? labelText;
  final String? hintText;
  final Function(double? value) onChanged;
  final B bloc;
  final double? Function(S state) stateValue;
  final bool nullable;
  final bool negative;
  final bool editable;

  final Color? color;

  const BlocTextFieldDouble({
    super.key,
    this.labelText,
    this.hintText,
    required this.onChanged,
    required this.bloc,
    required this.stateValue,
    this.negative = false,
    this.nullable = false,
    this.color,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocTextField<B, S, double>(
      labelText: labelText,
      hintText: hintText,
      onChanged: onChanged,
      bloc: bloc,
      enabled: editable,
      stateValue: stateValue,
      inputToValue: (String input) {
        final res = double.tryParse(input);
        return res ?? (nullable ? null : 0.0);
      },
      autocorrect: false,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: negative ? [_negativeLimitValidator] : [_limitValidator],
      color: color,
    );
  }
}



String? nullableValue(String input) => input.isNotEmpty ? input : null;

class BlocTextField<B extends BlocBase<S>, S, R> extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Function(R? value) onChanged;
  final R? Function(String value) inputToValue;
  final B bloc;
  final R? Function(S state) stateValue;

  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? autocorrect;
  final TextStyle? style;
  final int? maxLength;
  final bool? multiline;

  final FocusNode? focusNode;
  final bool obscureText;
  final bool enabled;
  final InputDecoration? decoration;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<R>? validator;
  final Color? cursorColor;
  final bool? autofocus;

  final bool? autocomplete;

  final Color? color;

  final bool handleTabKey;

  const BlocTextField({
    super.key,
    this.labelText,
    this.hintText,
    required this.onChanged,
    required this.bloc,
    required this.stateValue,
    required this.inputToValue,
    this.inputFormatters,
    this.keyboardType,
    this.autocorrect,
    this.style,
    this.maxLength,
    this.multiline,
    this.focusNode,
    this.obscureText = false,
    this.enabled = true,
    this.decoration,
    this.onFieldSubmitted,
    this.validator,
    this.cursorColor,
    this.autofocus,
    this.autocomplete,
    this.color,
    this.handleTabKey = false,
  });

  @override
  State<StatefulWidget> createState() => _BlocTextFieldState<B, S, R>();
}

class _BlocTextFieldState<B extends BlocBase<S>, S, R> extends State<BlocTextField<B, S, R>> {
  final _textController = TextEditingController();

  @override
  void initState() {
    final value = widget.stateValue(widget.bloc.state);
    _textController.value = _textController.value.copyWith(
      text: value?.toString() ?? '',
    );
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.autocomplete ?? false) {
      final globalKey = GlobalKey();

          return BlocListener<B, S>(
            bloc: widget.bloc,
            listenWhen: (previous, current) {
              return widget.stateValue(previous) != widget.stateValue(current);
            },
            listener: (context, state) {
              final value = widget.stateValue(state);
              if (value != widget.inputToValue(_textController.text)) {
                _textController.value = _textController.value.copyWith(
                  text: value?.toString() ?? '',
                );
              }
            },
            child: TextFormField(
              key: globalKey,
              focusNode: widget.focusNode,
              controller: _textController,
              onFieldSubmitted: (key) {
                widget.onFieldSubmitted?.call(key);
              },
              enabled: widget.enabled,
              autofocus: widget.autofocus ?? false,
              maxLines: (widget.multiline ?? false) ? null : 1,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.labelText ?? '',
                hintText: widget.hintText ?? '',
              ),
              onChanged: (value) {
                widget.onChanged(widget.inputToValue(value));
              },
            ),
          );

    }

    return Focus(
      onKeyEvent: (node, event) {
        if (widget.handleTabKey && event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.tab) {
          // // Insert a tab character
          final text = _textController.text;
          final selection = _textController.selection;
          final newText = text.replaceRange(selection.start, selection.end, '\t');
          final newSelection = TextSelection.collapsed(offset: selection.start + 1);
          setState(() {
            _textController.value = _textController.value.copyWith(
              text: newText,
              selection: newSelection,
              composing: TextRange.empty,
            );
            widget.onChanged(widget.inputToValue(newText));
          });
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: BlocListener<B, S>(
        bloc: widget.bloc,
        listenWhen: (previous, current) {
          return widget.stateValue(previous) != widget.stateValue(current);
        },
        listener: (context, state) {
          final value = widget.stateValue(state);
          if (value != widget.inputToValue(_textController.text)) {
            _textController.text = value?.toString() ?? '';
            // _textController.value = _textController.value.copyWith(
            //   text: value?.toString() ?? '',
            // );
          }
        },
        child: TextFormField(
          autofocus: widget.autofocus ?? false,
          maxLines: (widget.multiline ?? false) ? null : 1,
          maxLength: widget.maxLength,
          cursorColor: widget.cursorColor,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          focusNode: widget.focusNode,
          validator: (value) {
            return widget.validator?.call(widget.inputToValue(value ?? ''));
          },
          decoration: widget.decoration ??
              InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.labelText ?? '',
                hintText: widget.hintText ?? '',
              ),
          controller: _textController,
          onChanged: (value) {
            widget.onChanged(widget.inputToValue(value));
          },
          inputFormatters: widget.inputFormatters,
          autocorrect: widget.autocorrect ?? true,
          style: widget.style,
          keyboardType: widget.keyboardType,
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ),
    );
  }
}
