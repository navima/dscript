import gq.nagy.dscript.DSDeclLexer;
import gq.nagy.dscript.DSDeclParser;
import gq.nagy.dscript.DscriptLexer;
import org.antlr.v4.runtime.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.util.ArrayList;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class DSDeclTest {
    @ParameterizedTest
    @MethodSource("testDataProvider")
    public void test(String in) {
        // only tests for really big errors, not actual AST correctness.
        var lexer = new DSDeclLexer(CharStreams.fromString(in));
        var parser = new DSDeclParser(new CommonTokenStream(lexer));
        var errors = new ArrayList<>();
        var listener = new BaseErrorListener() {
            @Override
            public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) {
                errors.add(offendingSymbol);
                super.syntaxError(recognizer, offendingSymbol, line, charPositionInLine, msg, e);
            }
        };
        new DscriptLexer(CharStreams.fromString(in)).addErrorListener(listener);
        parser.addErrorListener(listener);

        // When
        parser.body();

        // Then
        assertTrue(errors.isEmpty());
    }

    public static Stream<Arguments> testDataProvider() {
        return Stream.of("""
                #declare enum
                enum direction = left right up down;

                #declare variable
                int i;

                #declare void return function
                void sum(int a, int b);

                #declare simple function
                int sum(int a, int b);

                #declare function with function parameter
                void apply(int i, int (int a, int b) fn);

                #declare function with function parameter that takes function
                void apply(int i, int (int a, int (int a, int b) fn2) fn1);

                #declare function with function parameter that returns function
                void apply(int i, int (int a, int b) (int a, int b) fn);

                #declare function with function parameter that takes function and returns function
                void apply(int i, int (int a, int b) (int a, int (int a, int b) fn2) fn);

                #declare function with function return value
                int (int a, int b) apply(int a, int b);"""
        ).map(e -> () -> new Object[]{e});
    }
}
