#import "CodeScorer.h"
#define EXP_SHORTHAND
#import "Expecta.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(CodeScorerSpec)

describe(@"CodeScorer", ^{
    __block CodeScorer *subject;

    beforeEach(^{
        subject = [[CodeScorer alloc] initWithSecretCode:@"rgby"];
    });

    describe(@"correctNumberOfColors", ^{
        it(@"should return 0 when all colors in right location", ^{
            NSString *guess = @"rgby";
            expect([subject correctNumberOfColors:guess]).to.equal(0);
        });

        it(@"should return 4 when all colors in wrong location", ^{
            NSString *guess = @"gryb";
            expect([subject correctNumberOfColors:guess]).to.equal(4);
        });
        
    });
    
    describe(@"correctNumberOfLocations", ^{
        it(@"should return 4 when all colors in right location", ^{
            NSString *guess = @"rgby";
            expect([subject correctNumberOfLocations:guess]).to.equal(4);
        });
        
        it(@"should return 0 when all colors in wrong locations", ^{
            NSString *guess = @"gryb";
            expect([subject correctNumberOfLocations:guess]).to.equal(0);
        });
        
    });

});

SPEC_END